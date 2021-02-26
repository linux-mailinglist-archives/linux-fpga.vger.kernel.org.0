Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ECE325B48
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Feb 2021 02:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZB16 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Feb 2021 20:27:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:2906 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhBZB16 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 25 Feb 2021 20:27:58 -0500
IronPort-SDR: Squc6HQX4ZBmB+uTvYGfMGa72gLvt4e/v7ElWSBEjfEspiWjyDeyvgHa478KSOzth9WCpfmSYa
 uI2o1yoS0lUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="249796086"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="249796086"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 17:27:16 -0800
IronPort-SDR: 1vssEaw4Sp2he7mO6sifjLBGn0zmJ2c3DqzYAYdLcJg8Mt1onoQHgaCSt33WvNz2X3OCc+hJKn
 gibAowFtAIzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="516325085"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2021 17:27:14 -0800
Date:   Fri, 26 Feb 2021 09:22:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v11 0/2] UIO support for dfl devices
Message-ID: <20210226012237.GA27194@yilunxu-OptiPlex-7050>
References: <1612403971-13291-1-git-send-email-yilun.xu@intel.com>
 <9b5f6e54-7122-8cfb-39f8-a84599e081f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5f6e54-7122-8cfb-39f8-a84599e081f1@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 22, 2021 at 10:56:45AM -0800, Tom Rix wrote:
> Yilun,
> 
> Is there anything outstanding or remaining to be done ?

Sorry for late reply. No, this is my lastest version now.


Hi Greg:

Do you have some comments on this patchset?

Thanks,
Yilun

> 
> Tom
> 
> On 2/3/21 5:59 PM, Xu Yilun wrote:
> > This patchset supports some dfl device drivers written in userspace.
> >
> > In the patchset v1, the "driver_override" interface should be used to bind
> > the DFL UIO driver to DFL devices. But there is concern that the 
> > "driver_override" interface is not OK itself.
> >
> > In v2, we use a new matching algorithem. The "driver_override" interface
> > is abandoned, the DFL UIO driver matches any DFL device which could not be
> > handled by other DFL drivers. So the DFL UIO driver could be used for new 
> > DFL devices which are not supported by kernel. The concern is the UIO may 
> > not be suitable as a default/generic driver for all dfl features, such as
> > features with multiple interrupts.
> >
> > In v4, we specify each matching device in the id_table of the UIO driver,
> > just the same as other dfl drivers do. Now the UIO driver supports Ether
> > Group feature. To support more DFL features, their feature ids should be
> > added to the driver's id_table.
> >
> > Before v9, we create a "uio_pdrv_genirq" platform device using DFL devices'
> > resources. Then we leverage the uio_pdrv_genirq driver for UIO support. It
> > is suggested that we implement a driver in drivers/uio that directly calls
> > UIO framework APIs. So we implement the uio_dfl driver in v9. The driver
> > now only binds the ether group feature, which has no irq. So the irq 
> > support is not implemented yet.
> >
> >
> > Main changes from v1:
> > - switch to the new matching algorithem. It matches DFL devices which could
> >   not be handled by other DFL drivers.
> > - refacor the code about device resources filling.
> > - add the documentation.
> >
> > Main changes from v2:
> > - split the match ops changes in dfl.c to an independent patch.
> > - move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
> >   to driver/fpga/dfl.h
> > - some minor fixes.
> >
> > Main changes from v3:
> > - switch to specifying each matching device in the driver's id_table.
> > - refactor the irq handling code.
> >
> > Main changes from v4:
> > - refactor the irq handling code.
> >
> > Main changes from v5:
> > - fix the res[] zero initialization issue.
> > - improve the return code for probe().
> > - some doc improvement.
> >
> > Main changes from v6:
> > - use platform_device_register_resndata() for pdev creation.
> >
> > Main changes from v7:
> > - some doc fixes.
> >
> > Main changes from v8:
> > - switch to add a uio driver in drivers/uio
> >
> > Main changes from v9:
> > - add this source file in MAINTAINERS
> > - improve the Kconfig, add more descriptive Kconfig header, add detailed
> >   path for opae uio example in Kconfig.
> >
> > Main changes from v10:
> > - add description in doc that interrupt support is not implemented yet.
> >
> >
> > Xu Yilun (2):
> >   uio: uio_dfl: add userspace i/o driver for DFL bus
> >   Documentation: fpga: dfl: Add description for DFL UIO support
> >
> >  Documentation/fpga/dfl.rst | 26 ++++++++++++++++++
> >  MAINTAINERS                |  1 +
> >  drivers/uio/Kconfig        | 17 ++++++++++++
> >  drivers/uio/Makefile       |  1 +
> >  drivers/uio/uio_dfl.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 111 insertions(+)
> >  create mode 100644 drivers/uio/uio_dfl.c
> >
