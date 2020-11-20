Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C82BB895
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Nov 2020 22:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKTVsu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 Nov 2020 16:48:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33248 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKTVst (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 Nov 2020 16:48:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id 81so8470806pgf.0;
        Fri, 20 Nov 2020 13:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5s9Nfl+0KYeKItM6n6lJJDSkgKhIjfqr5FQFmXMKTM=;
        b=lmySlCf+ICJIcaqBZwB/NJKMbVFwsar2xOIfZhVJMjlKYbVpxGSwDza3G8bDFbbFxS
         PMyJZ5Pt4ZhkTfdPTs9TEklEeIPcW39yYdoCyCU9FHFyEyx9CzkSim8zuOYGz/UrpZHG
         7XBP5kgUUI4htM77D0LbBWbbrBikO/zxAVWlTWWYvU95EsPyESeMrwUk97bY86SItx4n
         UxnyuzJHGObsyhYPCmI12CpXiAm2e/fCYcqiA/7XOhTPdqHqgR1dbxMv+T4AcIrechtk
         OIWBz0RbNqrX22HpuoYWb+i2i5KCnUpgdIr6r9PM0Xw6nZxJkjrAZmLtNfDlIWL+oIFj
         85RQ==
X-Gm-Message-State: AOAM532ZiAZmdoM5xqkb17MYMLZwZ9xqgW2UE2xDKcQ1Kh5wE182qsLa
        yGSxXi/SUeksNYH0TitqkA8=
X-Google-Smtp-Source: ABdhPJyl5Cc20dNbYPB3BbEG9Nj4aAlVcKLLHDXAo8+QU2Wt0fGuoBFL78TNX7/RtxYNIF7IQQbHQA==
X-Received: by 2002:a17:90a:aa0f:: with SMTP id k15mr12892893pjq.171.1605908928992;
        Fri, 20 Nov 2020 13:48:48 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id y23sm2209558pfb.207.2020.11.20.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:48:48 -0800 (PST)
Date:   Fri, 20 Nov 2020 13:48:47 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     David Gow <davidgow@google.com>, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Message-ID: <X7g5v94FINKC+f8i@archbook>
References: <20201119082209.3598354-1-davidgow@google.com>
 <X7dhwNFehhCRs7Ry@epycbox.lan>
 <CABVgOSmat7h9qqtEokwX69Aj-Q5AiAxU2G3yz_4ZMpmAArur7w@mail.gmail.com>
 <20201120074012.GB12837@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120074012.GB12837@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi David,

On Fri, Nov 20, 2020 at 03:40:13PM +0800, Xu Yilun wrote:
> On Fri, Nov 20, 2020 at 03:30:35PM +0800, David Gow wrote:
> > On Fri, Nov 20, 2020 at 2:27 PM Moritz Fischer <mdf@kernel.org> wrote:
> > >
> > > Hi David,
> > >
> > > On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> > > > Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> > > > 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> > > > functions, it should depend on HAS_IOMEM.
> > > >
> > > > This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> > > > HAS_IOMEM.
> > > >
> > > > Signed-off-by: David Gow <davidgow@google.com>
> > > > ---
> > > >  drivers/fpga/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > index 7cd5a29fc437..5645226ca3ce 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -142,6 +142,7 @@ config FPGA_DFL
> > > >       tristate "FPGA Device Feature List (DFL) support"
> > > >       select FPGA_BRIDGE
> > > >       select FPGA_REGION
> > > > +     depends on HAS_IOMEM
> > > >       help
> > > >         Device Feature List (DFL) defines a feature list structure that
> > > >         creates a linked list of feature headers within the MMIO space
> > > > --
> > > > 2.29.2.454.gaff20da3a2-goog
> > > >
> > > Do you think we can add a Fixes: tag for this?
> > 
> > Sure. I think it should be:
> > 
> > Fixes: 543be3d ("fpga: add device feature list support")
> 
> I think it should be:
> 
> Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")
I think so, yes.

Can you resend?

Cheers
