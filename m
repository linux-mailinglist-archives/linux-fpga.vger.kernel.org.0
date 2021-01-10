Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2852F0945
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbhAJTH3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Jan 2021 14:07:29 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:36348 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAJTH3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 10 Jan 2021 14:07:29 -0500
Received: by mail-pl1-f173.google.com with SMTP id j1so8357395pld.3;
        Sun, 10 Jan 2021 11:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i2zx80nmm8uLlk3zQRTl/iQoMYyET2eTo5B4q/iK/+U=;
        b=EYvubh5s/k0NzLi9X3ln1bD+0nUsDJKj+ohGuguvjUmZPKiEMumEiSZe/CoUcQXXgE
         HHcYEOmkQ5WFDJBwVjhMn02Uw8AzqVKBiJ3dL/62UqWD31HzezTLgC7AFxkKfmiY8Vn4
         B/ejCtPrqzUJcoboop6cOXvuJRGA9+SlbAM+uIL3FjPch7BC/u8ST3GV4vmdveWbKhRT
         yJNFTRgW3mEW0qNcnKoUElCKbDP4WGWUbjisknPPnGTmCjwZkC0O1Jdryc1a1OPdNhjR
         ljLy0MqP3s+yKW9goAvHPDPgWxYFkZfkAwdiqAxr17pwlivBkxlajrVnsUnIGCetwqe2
         MV8g==
X-Gm-Message-State: AOAM531KYtcc8sMRUQxAu5LbY/kYAid0/1rlWKhusrBkIYc/iUkzuXrH
        pYXb/g6u845syD7BO8SXVlk=
X-Google-Smtp-Source: ABdhPJwREp6OqBjnCtcAwjpX9UxI+Tp3AU6AdhW8qWuhYXQMpwjfFyBz3dxwoq53+SAwMKoNJK8owQ==
X-Received: by 2002:a17:902:b416:b029:dc:3657:9265 with SMTP id x22-20020a170902b416b02900dc36579265mr13115878plr.24.1610305608449;
        Sun, 10 Jan 2021 11:06:48 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id 36sm17146972pgr.56.2021.01.10.11.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 11:06:47 -0800 (PST)
Date:   Sun, 10 Jan 2021 11:06:45 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: fme: Constify static attribute_group structs
Message-ID: <X/tQRSxcbIoKJuZi@archbook>
References: <20210108235414.48017-1-rikard.falkeborn@gmail.com>
 <a1c87050-0962-5169-8ed4-c1da0098ff34@redhat.com>
 <X/ozuAn64pe71rh+@rikard>
 <55ca10fc-e52e-af47-609a-edaa65752a38@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ca10fc-e52e-af47-609a-edaa65752a38@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jan 09, 2021 at 05:40:38PM -0800, Tom Rix wrote:
> 
> On 1/9/21 2:52 PM, Rikard Falkeborn wrote:
> > On Sat, Jan 09, 2021 at 01:55:13PM -0800, Tom Rix wrote:
> >> On 1/8/21 3:54 PM, Rikard Falkeborn wrote:
> >>> The only usage of these is to put their addresses in arrays of pointers
> >>> to const attribute_groups. Make them const to allow the compiler to put
> >>> them in read-only memory.
> >>>
> >>> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> >>> ---
> >>>  drivers/fpga/dfl-fme-perf.c | 6 +++---
> >> This looks ok.
> >>
> >> There are other 'static struct's in drivers/fpga.
> >>
> >> Why is the change limited to this file ?
> >>
> >> Tom
> >>
> > I have a WIP coccinelle script to constify static struct attribute_group
> > and this is the only file in drivers/fpga which has non-const struct
> > attribute_group, that's why it's limited to this file. I could have
> > mentioned that in the commit message.
> 
> No worries, thanks for the change!
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> > Rikard
> >
> >
> >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> >>> index 531266287eee..4299145ef347 100644
> >>> --- a/drivers/fpga/dfl-fme-perf.c
> >>> +++ b/drivers/fpga/dfl-fme-perf.c
> >>> @@ -192,7 +192,7 @@ static struct attribute *fme_perf_cpumask_attrs[] = {
> >>>  	NULL,
> >>>  };
> >>>  
> >>> -static struct attribute_group fme_perf_cpumask_group = {
> >>> +static const struct attribute_group fme_perf_cpumask_group = {
> >>>  	.attrs = fme_perf_cpumask_attrs,
> >>>  };
> >>>  
> >>> @@ -225,7 +225,7 @@ static struct attribute *fme_perf_format_attrs[] = {
> >>>  	NULL,
> >>>  };
> >>>  
> >>> -static struct attribute_group fme_perf_format_group = {
> >>> +static const struct attribute_group fme_perf_format_group = {
> >>>  	.name = "format",
> >>>  	.attrs = fme_perf_format_attrs,
> >>>  };
> >>> @@ -239,7 +239,7 @@ static struct attribute *fme_perf_events_attrs_empty[] = {
> >>>  	NULL,
> >>>  };
> >>>  
> >>> -static struct attribute_group fme_perf_events_group = {
> >>> +static const struct attribute_group fme_perf_events_group = {
> >>>  	.name = "events",
> >>>  	.attrs = fme_perf_events_attrs_empty,
> >>>  };
> 
Applied,

Thanks
