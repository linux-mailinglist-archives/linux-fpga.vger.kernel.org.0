Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3EF46710C
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Dec 2021 05:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhLCEOl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Dec 2021 23:14:41 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:37498 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhLCEOl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Dec 2021 23:14:41 -0500
Received: by mail-pg1-f169.google.com with SMTP id 71so1814505pgb.4;
        Thu, 02 Dec 2021 20:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=chRUSqEaLCK4UXGMRZ4Wp7NZZHHltrpYU9yCMPNxKBw=;
        b=0J8Js3DTC7m1ZtlU5q1s/gJMCfUAGDz02yTpp14lQfdAskJLILDndgTM7p7II6KmOc
         UxLkOnmTQojCq7zlM05Uxgd+ekbSXWF4wbXmNVxOE8WYaelN9eHQMrQUeUm8ztBBlKah
         cvABsOtLftwjyrl3ssvSzAdlEIDs/28d7QEUQAnGDKdEUFogm+35ZErjTMUTcADCZVVc
         IyhYOf1C4lTjP5cB9vmn9IHHsKO9B7dHtbuQTmNUPyRPugKyg6g5ENmTov94X6B2pGbF
         u8RtIgla/mVMLJx07gwMnren1sgZbrodvTUSyFCqHG97ch/A5QPeMZ5Jd7TnySHVGcMO
         A4tw==
X-Gm-Message-State: AOAM532fgR1rx4g2DdlEZ82xic3TteWdhjszj+gkK58BIPVd7C8BAquf
        u19opNkWlCKi/v72L6+q+GY=
X-Google-Smtp-Source: ABdhPJzyrjA7mvvSflGdB/FBJvi4Ndvghcg3KwMAl6A255/bQSoWYDxUfaWAbtHgXyYG81Dv1Wr3kA==
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr2690041pgs.489.1638504677530;
        Thu, 02 Dec 2021 20:11:17 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id v25sm1283780pfg.175.2021.12.02.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 20:11:17 -0800 (PST)
Date:   Thu, 2 Dec 2021 20:11:16 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH -next] fpga: region: fix kernel-doc
Message-ID: <YamY5IwKiQSU/BZf@epycbox.lan>
References: <1638499487-74388-1-git-send-email-yang.lee@linux.alibaba.com>
 <dd215074-38bc-5011-3e52-78858e9e2ea6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd215074-38bc-5011-3e52-78858e9e2ea6@infradead.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yang,

On Thu, Dec 02, 2021 at 07:02:16PM -0800, Randy Dunlap wrote:

> Hi--
> 
> On 12/2/21 18:44, Yang Li wrote:
> > Fix function name in of-fpga-region.c kernel-doc comment
> > to remove a warning found by clang(make W=1 LLVM=1).
> 
> The patch below looks good, but the commit message about
> "found by clang" is not correct. Using 'make W=1' causes
> scripts/kernel-doc to run, and this warning message is from kernel-doc,
> not from clang.
> 
> > drivers/fpga/of-fpga-region.c:451: warning: expecting prototype for
> > fpga_region_init(). Prototype was for of_fpga_region_init() instead.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > ---
> >  drivers/fpga/of-fpga-region.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> > index 9c662db..50b8305 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -444,7 +444,7 @@ static int of_fpga_region_remove(struct platform_device *pdev)
> >  };
> >  
> >  /**
> > - * fpga_region_init - init function for fpga_region class
> > + * of_fpga_region_init - init function for fpga_region class
> >   * Creates the fpga_region class and registers a reconfig notifier.
> >   */
> >  static int __init of_fpga_region_init(void)
> > 
> 
> thanks.
> -- 
> ~Randy

Can you resend with these addressed?

Thanks
