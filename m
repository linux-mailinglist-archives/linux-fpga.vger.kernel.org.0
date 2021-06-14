Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C863A6D56
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhFNRmp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:42:45 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33561 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhFNRmo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:42:44 -0400
Received: by mail-pl1-f179.google.com with SMTP id u18so6343146plc.0
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pO4lXXykZyoWlieRBAbKiYKD26aDYBYGW2DESqGQY68=;
        b=ckNBaVc8BpLoymfF0ivF2JXvDdnMfwElkcEhzA9wDuuAbo1cwem/zgETqZsAadXFEQ
         vlRPMD7nrAcsIS5DSyoBDROYGUoxi/uqrSNLl/DFFEGeL9jptFMUqhetGZpPA8lCXP6m
         dS/cJVecKnmVuO6TD+1+yI5q5+iKLs+meYvoijB5VnyIpGerKrATvUFN8tmcTsK0UiBy
         aBthwE6SoYURsVl5PpgM0A3lQy2+LNXv1Gn95IGiET19EUnHlbe6d+3n/P/IDO2znQ1h
         ivcHHEBg2bj84EtL9SQixtU0iLW3MKphUDkhDb+5UQO4OKhGWsZmwRAu0gcgXv2JaWJm
         9MWQ==
X-Gm-Message-State: AOAM531FDQ0kYcmMQFNjpuoHPGmAqnFpSH7nmOsnEJAdE/pcF/YRBfAa
        5QtN/1IUFdN19/EDh+P/q+g=
X-Google-Smtp-Source: ABdhPJxX18alno0jvVQdX8Y6YYYuOwfp1sD8MgdQe5s8hVU6ajsJKe8CrV/quR6jstLQRox8ZtFrRw==
X-Received: by 2002:a17:90a:708:: with SMTP id l8mr252582pjl.103.1623692441781;
        Mon, 14 Jun 2021 10:40:41 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s7sm12307020pfh.57.2021.06.14.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:40:41 -0700 (PDT)
Date:   Mon, 14 Jun 2021 10:40:39 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Message-ID: <YMeUl0jENlplhWsg@epycbox.lan>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-3-mdf@kernel.org>
 <YMeSG6puw7/4OZ6b@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMeSG6puw7/4OZ6b@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 07:30:03PM +0200, Greg KH wrote:
> On Mon, Jun 14, 2021 at 10:09:03AM -0700, Moritz Fischer wrote:
> > From: Russ Weight <russell.h.weight@intel.com>
> > 
> > The stratix10-soc driver uses fpga_mgr_create() function and is therefore
> > responsible to call fpga_mgr_free() to release the class driver resources.
> > Add a missing call to fpga_mgr_free in the s10_remove() function.
> > 
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/stratix10-soc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index 657a70c5fc99..9e34bbbce26e 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
> >  	struct s10_priv *priv = mgr->priv;
> >  
> >  	fpga_mgr_unregister(mgr);
> > +	fpga_mgr_free(mgr);
> >  	stratix10_svc_free_channel(priv->chan);
> >  
> >  	return 0;
> > -- 
> > 2.31.1
> > 
> 
> Does this fix a specific commit?  Does it need a Fixes: and cc: stable
> line too?

Yes, I missed this. I think this should be:
Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager
driver")

I can resend with Cc: stable

Thanks,
Moritz

