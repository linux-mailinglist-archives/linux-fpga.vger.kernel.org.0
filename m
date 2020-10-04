Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1C282E59
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 01:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgJDXjS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 19:39:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46928 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJDXjS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 19:39:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id y14so2224255pfp.13;
        Sun, 04 Oct 2020 16:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0z6tvnBKutMrc8NANVNxZ4vgDVqspXt5PjdV91Nld0=;
        b=cghaDKIoCmc+tCUrZw5Pd5l7U1JlJghddEikRKw3N9SXlhWBsUITbQTt7XubxVGYeD
         2wcssyKBUpjGiy/gZb/TF4qKh+qx1CTrdzbUVBR44bU4abDMCnDImWee1d4VKSvAYDwB
         n+R7uiYecSvoNHl4KN5dLxAfYSeWTG8QP3sONiXpch68lO1fT19ZDg1bbsUIuJqT2COi
         gbKyZoqy6wDfrTLs8xvpyjSNK/+3I5YPA7ADCAg63isknKDcLAUGkdv6uKQXfornQ6L1
         2qcceqvlCQ2zRqy7PNgPvGNcByw3cumHvWzDuHRoW4uW/54gzSPtI+q+CUXrCHlY4Xdb
         ncOw==
X-Gm-Message-State: AOAM5302Zgx3TKrkJYFYQlRdu0VDlNnLjbU4NP0LPRp14WiWalIkUCPo
        qaISOOOOaUmgCTrmGUxlm0E=
X-Google-Smtp-Source: ABdhPJwDxjYqwd4SsWoA/szwThk1/VQI0lALPbyUXTRS6XaJ9gGayf2gFHtJoOZM9WEaaCOvTkyQ4A==
X-Received: by 2002:a63:f006:: with SMTP id k6mr11547499pgh.88.1601854756304;
        Sun, 04 Oct 2020 16:39:16 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id h12sm9786071pfo.68.2020.10.04.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 16:39:15 -0700 (PDT)
Date:   Sun, 4 Oct 2020 16:39:14 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify registration
Message-ID: <20201004233914.GA111357@epycbox.lan>
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-11-mdf@kernel.org>
 <a49b1d7c-9756-1059-f7a1-25dae460d659@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49b1d7c-9756-1059-f7a1-25dae460d659@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Oct 04, 2020 at 11:47:26AM -0700, Tom Rix wrote:
> 
> On 10/3/20 10:14 PM, Moritz Fischer wrote:
> > Simplify registration using new devm_fpga_mgr_register() API.
> > Remove the now obsolete altera_pr_unregister() function.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >
> > We should take another look at this, IIRC correctly the point of
> > splitting this up into a separate driver was to make it useable by a
> > different (pci?) driver later on.
> >
> > It doesn't seem like this happened, and I think we should just make this
> > a platform driver?
> >
> > ---
> >  drivers/fpga/altera-pr-ip-core-plat.c  | 10 ----------
> >  drivers/fpga/altera-pr-ip-core.c       | 14 +-------------
> >  include/linux/fpga/altera-pr-ip-core.h |  1 -
> >  3 files changed, 1 insertion(+), 24 deletions(-)
> >
> > diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
> > index 99b9cc0e70f0..b008a6b8d2d3 100644
> > --- a/drivers/fpga/altera-pr-ip-core-plat.c
> > +++ b/drivers/fpga/altera-pr-ip-core-plat.c
> > @@ -28,15 +28,6 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
> >  	return alt_pr_register(dev, reg_base);
> >  }
> >  
> > -static int alt_pr_platform_remove(struct platform_device *pdev)
> > -{
> > -	struct device *dev = &pdev->dev;
> > -
> > -	alt_pr_unregister(dev);
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct of_device_id alt_pr_of_match[] = {
> >  	{ .compatible = "altr,a10-pr-ip", },
> >  	{},
> > @@ -46,7 +37,6 @@ MODULE_DEVICE_TABLE(of, alt_pr_of_match);
> >  
> >  static struct platform_driver alt_pr_platform_driver = {
> >  	.probe = alt_pr_platform_probe,
> > -	.remove = alt_pr_platform_remove,
> >  	.driver = {
> >  		.name	= "alt_a10_pr_ip",
> >  		.of_match_table = alt_pr_of_match,
> > diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> > index 2cf25fd5e897..dfdf21ed34c4 100644
> > --- a/drivers/fpga/altera-pr-ip-core.c
> > +++ b/drivers/fpga/altera-pr-ip-core.c
> > @@ -195,22 +195,10 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
> >  	if (!mgr)
> >  		return -ENOMEM;
> >  
> > -	dev_set_drvdata(dev, mgr);
> > -
> > -	return fpga_mgr_register(mgr);
> > +	return devm_fpga_mgr_register(dev, mgr);
> >  }
> >  EXPORT_SYMBOL_GPL(alt_pr_register);
> >  
> > -void alt_pr_unregister(struct device *dev)
> > -{
> > -	struct fpga_manager *mgr = dev_get_drvdata(dev);
> > -
> > -	dev_dbg(dev, "%s\n", __func__);
> > -
> > -	fpga_mgr_unregister(mgr);
> > -}
> > -EXPORT_SYMBOL_GPL(alt_pr_unregister);
> 
> Similar to the others, except for removing this symbol.
> 
> A patch should do one logical thing.

I was on the fence with this. Tbh, this driver should be a platform
driver. I'll create a separate series for that.

> 
> I'd rather this be split out of the patchset.
> 
> Tom
> 
> > -
> >  MODULE_AUTHOR("Matthew Gerlach <matthew.gerlach@linux.intel.com>");
> >  MODULE_DESCRIPTION("Altera Partial Reconfiguration IP Core");
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
> > index 0b08ac20ab16..a6b4c07858cc 100644
> > --- a/include/linux/fpga/altera-pr-ip-core.h
> > +++ b/include/linux/fpga/altera-pr-ip-core.h
> > @@ -13,6 +13,5 @@
> >  #include <linux/io.h>
> >  
> >  int alt_pr_register(struct device *dev, void __iomem *reg_base);
> > -void alt_pr_unregister(struct device *dev);
> >  
> >  #endif /* _ALT_PR_IP_CORE_H */
> 

Cheers,
Moritz
