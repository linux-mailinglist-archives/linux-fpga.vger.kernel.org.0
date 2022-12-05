Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645AD642626
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiLEJvq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 04:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLEJvW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 04:51:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916ABF40;
        Mon,  5 Dec 2022 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670233881; x=1701769881;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=LV6SJb6CoxRrYKPqlCynj4Tzp1gYyxkdHzceN4TchLE=;
  b=CbZKPLsM1k4aC3wZsOono+m4n2Odhly1vcrprGizaAnxUgEPeUK0Q8Vo
   bkyYCBaUx/yeYEBBoacacyVdugqUBDeB9tOFmIAmBbxZDiVRuJlybmMeG
   lO+X6NjRiSNfMPcz068ujd2ZNlCqIB6mJaxklJJltBC/dJEr2d1bToTWx
   i35rbNPJsjUw2BRWtMPgHmggB9wNLhvr/7C/EJSnzf3oNu196V0Ai3t4C
   +/68yLZTmNdst7hsmxcOL9hPf4eivTqGWIK4N6UUmBgq5eoy44gCwhmai
   UYcVZeP0CZg0sHiGj1CXkVkQL10jWHhQlSgyJ45VtDbPU0wiRdhExK5Pm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="402583584"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="402583584"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:51:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="709197986"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="709197986"
Received: from andreial-mobl.ger.corp.intel.com ([10.251.213.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:51:17 -0800
Date:   Mon, 5 Dec 2022 11:51:15 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Mark Brown <broonie@kernel.org>
cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] mfd: intel-m10-bmc: Add PMCI driver
In-Reply-To: <Y4ox5J0junaUYyT7@yilunxu-OptiPlex-7050>
Message-ID: <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com> <20221202100841.4741-8-ilpo.jarvinen@linux.intel.com> <Y4ox5J0junaUYyT7@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-12084522-1670230448=:1615"
Content-ID: <44685fa4-6a7-10d7-d58d-b8e259d5427@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-12084522-1670230448=:1615
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <564468c9-8bb2-e12e-b538-d856eb553@linux.intel.com>

On Sat, 3 Dec 2022, Xu Yilun wrote:

> On 2022-12-02 at 12:08:39 +0200, Ilpo Järvinen wrote:
> > Add the mfd driver for the Platform Management Component Interface
> > (PMCI) based interface of Intel MAX10 BMC controller.
> > 
> > PMCI is a software-visible interface, connected to card BMC which
> > provided the basic functionality of read/write BMC register. This
> > driver leverages the regmap APIs to support Intel specific Indirect
> > Register Interface for register read/write on PMCI.
> > 
> > Previously, intel-m10-bmc provided sysfs under
> > /sys/bus/spi/devices/... which is generalized in this change because
> > not all MAX10 BMC appear under SPI anymore.
> > 
> > This patch also adds support for indirect register access via a regmap
> > interface. The access to the register goes via a hardware
> > controller/bridge that handles read/write/clear commands and
> > acknowledgments for the commands. On Intel FPGA IPs with e.g. PMCI or
> > HSSI, indirect register access is a generic way to access registers.
> > 
> > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
> >  drivers/mfd/Kconfig                           |  12 ++
> >  drivers/mfd/Makefile                          |   2 +
> >  drivers/mfd/intel-m10-bmc-pmci-indirect.c     | 133 ++++++++++++++++
> >  drivers/mfd/intel-m10-bmc-pmci-main.c         | 147 ++++++++++++++++++
> >  include/linux/mfd/intel-m10-bmc.h             |  22 +++
> >  6 files changed, 320 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/mfd/intel-m10-bmc-pmci-indirect.c
> >  create mode 100644 drivers/mfd/intel-m10-bmc-pmci-main.c
> > 
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -2238,6 +2238,18 @@ config MFD_INTEL_M10_BMC_SPI
> >            additional drivers must be enabled in order to use the functionality
> >            of the device.
> >  
> > +config MFD_INTEL_M10_BMC_PMCI
> > +	tristate "Intel MAX 10 Board Management Controller with PMCI"
> > +	depends on FPGA_DFL
> > +	select MFD_INTEL_M10_BMC_CORE
> > +	select REGMAP
> > +	help
> > +	  Support for the Intel MAX 10 board management controller via PMCI.
> > +
> > +	  This driver provides common support for accessing the device,
> > +	  additional drivers must be enabled in order to use the functionality
> > +	  of the device.
> > +
> >  config MFD_RSMU_I2C
> >  	tristate "Renesas Synchronization Management Unit with I2C"
> >  	depends on I2C && OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 5d1f308ee2a7..603c0a8f1241 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -274,6 +274,8 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> >  
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)	+= intel-m10-bmc-core.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)	+= intel-m10-bmc-spi.o
> > +intel-m10-bmc-pmci-objs			:= intel-m10-bmc-pmci-main.o intel-m10-bmc-pmci-indirect.o
> > +obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)	+= intel-m10-bmc-pmci.o
> >  
> >  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
> >  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> > diff --git a/drivers/mfd/intel-m10-bmc-pmci-indirect.c b/drivers/mfd/intel-m10-bmc-pmci-indirect.c
> > new file mode 100644
> > index 000000000000..cf347f93c05d
> > --- /dev/null
> > +++ b/drivers/mfd/intel-m10-bmc-pmci-indirect.c
> > +
> > +struct regmap *__devm_m10_regmap_indirect(struct device *dev,
> 
> We name the file intel-m10-bmc-pmci-xxx.c, and this function
> xx_m10_regmap_xx(). But I can see the implementation is just about the indirect
> bus which from your commit message could be used by various DFL features
> like HSSI or PMCI. So is it better we put the implementation in
> drivers/fpga and name the file dfl-indirect-regmap.c and the
> initialization function dfl_indirect_regmap_init()?

I guess that would be doable unless Mark objects. My understanding was 
that he preferred to have in the driver that is currently using it.

Mark, any opinion on this?

> > +					  void __iomem *base,
> > +					  struct regmap_config *cfg,
> > +					  struct lock_class_key *lock_key,
> > +					  const char *lock_name)
> > +{
> > +	struct indirect_ctx *ctx;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return NULL;
> > +
> > +	ctx->base = base;
> > +	ctx->dev = dev;
> > +
> > +	indirect_bus_clear_cmd(ctx);
> > +
> > +	return __devm_regmap_init(dev, &indirect_bus, ctx, cfg, lock_key, lock_name);
> 
> Sorry, I just can't remember why don't we just call devm_regmap_init() and
> get rid of all lock stuff?

At this point, we're already entered into __-domain though a
__regmap_lockdep_wrapper(). If I call devm_regmap_init() here, the 
second call into the wrapper would create another key which doesn't seem 
right.

> > +#define M10BMC_PMCI_STAGING_FLASH_COUNT	0x7ff5000
> 
> The same concern here, should all PMCI based M10 BMC have the same
> register layout? I assume no. I still think the layout should be decided
> by board type.
> 
> So some concern about these naming.

Noted, lets discuss the solution in the other patch.


-- 
 i.
--8323329-12084522-1670230448=:1615--
