Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE271249801
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Aug 2020 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHSILp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 Aug 2020 04:11:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:41893 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgHSILo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 Aug 2020 04:11:44 -0400
IronPort-SDR: LsiHm9uPnCT031TueHu3RcAByriBCoLlCzGXCtk7IhtLn0JIuMCbpmWV5nEtE0owFl08Io0b1T
 dcy8GNhTzSfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="219370985"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="219370985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 01:11:43 -0700
IronPort-SDR: Z49Pch4lxOJzp3iUslwLCb8yl1WixJSdDwf+46h89vYah7xh4AOWplzcjfLtdXlQRCnaj1ZKHC
 q3FE/Iv7gkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="497674177"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2020 01:11:41 -0700
Date:   Wed, 19 Aug 2020 16:07:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v6 3/3] fpga: dfl: add support for N3000 Nios private
  feature
Message-ID: <20200819080754.GB11659@yilunxu-OptiPlex-7050>
References: <1597653612-5064-1-git-send-email-yilun.xu@intel.com>
 <1597653612-5064-4-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819D440AA27D2BC466B61E5855F0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819D440AA27D2BC466B61E5855F0@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thanks for your review, I'll fix them. Only one comment inline.

On Mon, Aug 17, 2020 at 05:43:51PM +0800, Wu, Hao wrote:
> > Subject: [PATCH v6 3/3] fpga: dfl: add support for N3000 Nios private feature
> >
> > This patch adds support for the Nios handshake private feature on Intel
> > PAC (Programmable Acceleration Card) N3000.
> >
> > The Nios is the embedded processor on the FPGA card. This private feature
> > provides a handshake interface to FPGA Nois firmware, which receives
> > retimer configuration command from host and executes via an internal SPI
> > master (spi-altera). When Nios finishes the configuration, host takes over
> > the ownership of the SPI master to control an Intel MAX10 BMC (Board
> > Management Controller) Chip on the SPI bus.
> >
> > For Nios firmware handshake part, this driver requests the retimer
> > configuration for Nios with parameters from module param, and adds some
> > sysfs nodes for user to query the onboard retimer's working mode and
> > Nios firmware version.
> >
> > For SPI part, this driver adds a spi-altera platform device as well as
> > the MAX10 BMC spi slave info. A spi-altera driver will be matched to
> > handle the following SPI work.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> 
> With some minor fixings below,
> 
> Acked-by: Wu Hao <hao.wu@intel.com>
> 
> Thanks
> Hao
> 
> > ---
> > v3: Add the doc for this driver
> >     Minor fixes for comments from Tom
> > v4: Move the err log in regmap implementation, and delete
> >      n3000_nios_writel/readl(), they have nothing to wrapper now.
> >     Some minor fixes and comments improvement.
> > v5: Fix the output of fec_mode sysfs inf to "no" on 10G configuration,
> >      cause no FEC mode could be configured for 10G.
> >     Rename the dfl_n3000_nios_* to n3000_nios_*
> >     Improves comments.
> > v6: Fix the output of fec_mode sysfs inf to "not supported" if in 10G,
> >      or the firmware version major < 3.
> >     Minor fixes and improves comments.
> > ---
> >  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  21 +
> >  Documentation/fpga/dfl-n3000-nios.rst              |  79 +++
> >  Documentation/fpga/index.rst                       |   1 +
> >  drivers/fpga/Kconfig                               |  11 +
> >  drivers/fpga/Makefile                              |   2 +
> >  drivers/fpga/dfl-n3000-nios.c                      | 539 +++++++++++++++++++++
> >  6 files changed, 653 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-
> > n3000-nios
> >  create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
> >  create mode 100644 drivers/fpga/dfl-n3000-nios.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > new file mode 100644
> > index 0000000..ce5b474
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > @@ -0,0 +1,21 @@
> > +What:/sys/bus/dfl/devices/dfl_dev.X/fec_mode
> > +Date:Aug 2020
> > +KernelVersion:5.10
> > +Contact:Xu Yilun <yilun.xu@intel.com>
> > +Description:Read-only. It returns the FEC mode of the 25G links of the
> > +ethernet retimers configured by NIOS firmware. "rs" for Reed
> > +Solomon FEC, "kr" for Fire Code FEC, "no" for NO FEC.
> > +"not supported" if the FEC mode setting is not supported,
> > this
> > +happens when the Nios firmware version major < 3, or no
> > link is
> > +configured to 25G. The FEC mode could be set by module
> 
> or all links are configured to 10G.

I think "no link is configured to 25G" may be better.

1. At the start of the description of the fec_mode, I wrote "It returns
the FEC mode of the 25G links ..." So it may be better we say "no link
is configured to 25G" as the condition of "not supported". I'm not sure
if in future there are 40G, 50G ... links, and if the 40G, 50G links have
the fec mode setting. So I just say we limit the scope of this node to
25G.

2. If some links are configured to reset and some are configured to 10G,
or all links are in reset. The output of fec_mode is still "not
supported".

Thanks,
Yilun.
