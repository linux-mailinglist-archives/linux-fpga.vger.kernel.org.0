Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43C92F042B
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Jan 2021 23:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbhAIWx1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 Jan 2021 17:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIWx1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 Jan 2021 17:53:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0EC061786;
        Sat,  9 Jan 2021 14:52:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s26so31865433lfc.8;
        Sat, 09 Jan 2021 14:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vN30hxhyeC5Ec58tchhlNmFh+S+moOBZF/ui6MMTzYg=;
        b=fzsavMinEeJg7wgHZS4usSEFjDXVSw+1Jm14Ljta0ZKw1l90c9ZCEMsNTWOpn5V2yp
         kFVcItk9xEq6YsG2aySeFyrDwiZx2tLK9zihYRnUSGtZWfIviiAZ826sIcHceIXfwo4Y
         H02LHGCuxeQS8hZiPiF64GWwXzlv7PgTsK/c1duCyi3wgTHwVY61vZOmdlVVDqIiZwDJ
         PQm1YPcIOT7XukipOrFtvs70+jOhlwJLAyfJsGSAHF3QHNYAAcIn2sRaqFmothyKfH7p
         V4ZehhlgpmrgsHMnYz9WcyE5E0l6+LQo3Q5EYYoNbCpJNGjHCjgTJC81PNDEM/q2nThB
         k/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vN30hxhyeC5Ec58tchhlNmFh+S+moOBZF/ui6MMTzYg=;
        b=XisXi9jRcc1OZ+AOdO/F9VXf84raytk+CXee8oykTjTRCq+vL+90wKO3QZja0obek0
         XGZDdBTo+pYYouKNibh63VjaLkxmWKl0mCFJz60G8Li0hcGN3yAnFMv68v0LPiwvvZcc
         Ohp4ItawJFi8rTH1Qvg89G6Jrai2ItyStVwYMieDbfIO5/D3OGK1VN3YWWsZ1MVcltmp
         9uu115fNnHeeZADsgu00Avg2Dgty+LSmOgqAovygfI8tw7DhZ03GaXtSqWLL2s8+SPwz
         FHTg3piDrZmfy3lOLQQFF8DvdsO01+GOvEbhKvvzAysR6+S8LmfIYhRrxmUIDAt8Yb8x
         MySA==
X-Gm-Message-State: AOAM531V+c28QL4+pGsdrZmy2ohmUyVkuL1FohaZq7NsyYzxzyk9M9Ui
        PYiYRC64NyAq8UDXOaMEBkQ=
X-Google-Smtp-Source: ABdhPJzZrGUDVMjLnOkooECI1+sx1bKVX7L9oMm+yaOvC/U2HUZ8tczmel8xz4UeFZsFnzTC6voreQ==
X-Received: by 2002:a19:6415:: with SMTP id y21mr4130872lfb.120.1610232765196;
        Sat, 09 Jan 2021 14:52:45 -0800 (PST)
Received: from rikard (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id k20sm2675238ljc.61.2021.01.09.14.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 14:52:44 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Sat, 9 Jan 2021 23:52:40 +0100
To:     Tom Rix <trix@redhat.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: fme: Constify static attribute_group structs
Message-ID: <X/ozuAn64pe71rh+@rikard>
References: <20210108235414.48017-1-rikard.falkeborn@gmail.com>
 <a1c87050-0962-5169-8ed4-c1da0098ff34@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c87050-0962-5169-8ed4-c1da0098ff34@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jan 09, 2021 at 01:55:13PM -0800, Tom Rix wrote:
> 
> On 1/8/21 3:54 PM, Rikard Falkeborn wrote:
> > The only usage of these is to put their addresses in arrays of pointers
> > to const attribute_groups. Make them const to allow the compiler to put
> > them in read-only memory.
> >
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >  drivers/fpga/dfl-fme-perf.c | 6 +++---
> 
> This looks ok.
> 
> There are other 'static struct's in drivers/fpga.
> 
> Why is the change limited to this file ?
> 
> Tom
> 

I have a WIP coccinelle script to constify static struct attribute_group
and this is the only file in drivers/fpga which has non-const struct
attribute_group, that's why it's limited to this file. I could have
mentioned that in the commit message.

Rikard


> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> > index 531266287eee..4299145ef347 100644
> > --- a/drivers/fpga/dfl-fme-perf.c
> > +++ b/drivers/fpga/dfl-fme-perf.c
> > @@ -192,7 +192,7 @@ static struct attribute *fme_perf_cpumask_attrs[] = {
> >  	NULL,
> >  };
> >  
> > -static struct attribute_group fme_perf_cpumask_group = {
> > +static const struct attribute_group fme_perf_cpumask_group = {
> >  	.attrs = fme_perf_cpumask_attrs,
> >  };
> >  
> > @@ -225,7 +225,7 @@ static struct attribute *fme_perf_format_attrs[] = {
> >  	NULL,
> >  };
> >  
> > -static struct attribute_group fme_perf_format_group = {
> > +static const struct attribute_group fme_perf_format_group = {
> >  	.name = "format",
> >  	.attrs = fme_perf_format_attrs,
> >  };
> > @@ -239,7 +239,7 @@ static struct attribute *fme_perf_events_attrs_empty[] = {
> >  	NULL,
> >  };
> >  
> > -static struct attribute_group fme_perf_events_group = {
> > +static const struct attribute_group fme_perf_events_group = {
> >  	.name = "events",
> >  	.attrs = fme_perf_events_attrs_empty,
> >  };
> 
