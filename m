Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612E82BA3BC
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Nov 2020 08:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgKTHob (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 Nov 2020 02:44:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:54573 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgKTHo3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 20 Nov 2020 02:44:29 -0500
IronPort-SDR: 3prmRSi9VDPSoAeU2CWgksacjtzspEt0r3uJHHnAXkFlRcDmTXVxGxEPW9Z8miQ2WdmNuVMHbh
 6n54LVqzIIjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="170650725"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="170650725"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 23:44:28 -0800
IronPort-SDR: JSgmKkWhSKvwjbyT4xukwYN22Id1L+Myw3Q2eWXWrK7oNLH9MmgYstg8geclzANnqF3bs+h4/W
 KhcfgXSgYEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,355,1599548400"; 
   d="scan'208";a="545344918"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2020 23:44:26 -0800
Date:   Fri, 20 Nov 2020 15:40:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Message-ID: <20201120074012.GB12837@yilunxu-OptiPlex-7050>
References: <20201119082209.3598354-1-davidgow@google.com>
 <X7dhwNFehhCRs7Ry@epycbox.lan>
 <CABVgOSmat7h9qqtEokwX69Aj-Q5AiAxU2G3yz_4ZMpmAArur7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmat7h9qqtEokwX69Aj-Q5AiAxU2G3yz_4ZMpmAArur7w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Nov 20, 2020 at 03:30:35PM +0800, David Gow wrote:
> On Fri, Nov 20, 2020 at 2:27 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > Hi David,
> >
> > On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> > > Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> > > 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> > > functions, it should depend on HAS_IOMEM.
> > >
> > > This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> > > HAS_IOMEM.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >  drivers/fpga/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 7cd5a29fc437..5645226ca3ce 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -142,6 +142,7 @@ config FPGA_DFL
> > >       tristate "FPGA Device Feature List (DFL) support"
> > >       select FPGA_BRIDGE
> > >       select FPGA_REGION
> > > +     depends on HAS_IOMEM
> > >       help
> > >         Device Feature List (DFL) defines a feature list structure that
> > >         creates a linked list of feature headers within the MMIO space
> > > --
> > > 2.29.2.454.gaff20da3a2-goog
> > >
> > Do you think we can add a Fixes: tag for this?
> 
> Sure. I think it should be:
> 
> Fixes: 543be3d ("fpga: add device feature list support")

I think it should be:

Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")

Thanks,
Yilun

> 
> Let me know if you want me to re-send the patch with that included.
> 
> Cheers,
> -- David
