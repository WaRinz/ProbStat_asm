%this function belong to https://www.mathworks.com/matlabcentral/fileexchange/30217-stem-and-leaf-plot

function stemleafplot(v,p)

if ~isnumeric(v); error 'Input V must be numeric'; end
if ~exist('p','var'); p = 0; elseif isempty(p); p = 0; end
if ~isnumeric(p); error 'Input P must be an integer'; end
p = round(p);

% Condition V
v = v(~isnan(v));
v = v(:);
v = roundn(v,p);

% Organize stems and leaves
allstems = floor(v./10^(p+1));
allleaves = round(abs(v./10^p));

nstems = allstems(allstems<0)+1; 	% Negative stems
nstems = nstems(:);
pstems = allstems(~(allstems<0));	% Positive stems
pstems = pstems(:);

nleaves = allleaves(allstems<0);    % Negative leaves
nleaves = nleaves(:);
pleaves = allleaves(~(allstems<0)); % Negative leaves
pleaves = pleaves(:);

dig = ceil(max(log10(abs(allstems))))+1;    % Max # of digits in stem
form = strcat(['%' num2str(dig+1) 'i']);    % Format string for SPRINTF

% Plot negative stems
if ~isempty(nstems)
    for ii = min(nstems(:)):0
        strstem = sprintf(form,ii);
        if ii==0; strstem(end-1:end) = '-0'; end
        strleaves = sprintf('%2i',mod(sort(nleaves(nstems==ii)),10));
        s = strcat([strstem '. |' strleaves]);
        disp(s)
    end % NSTEMS
end % IF

% Plot positive stems
if ~isempty(pstems)
    for ii = 0:max(pstems(:))
        strstem = sprintf(form,ii);
        strleaves = sprintf('%2i',mod(sort(pleaves(pstems==ii)),10));
        s = strcat([strstem '. |' strleaves]);
        disp(s)
    end % PSTEMS
end % IF

end % MAIN
