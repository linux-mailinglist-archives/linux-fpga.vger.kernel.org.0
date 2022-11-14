Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A6627692
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Nov 2022 08:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiKNHnx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 02:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiKNHng (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 02:43:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E71A066;
        Sun, 13 Nov 2022 23:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668411794; x=1699947794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xqcegeMZPyeSg/or0q5hsQy5hMh4CkZ2K4fwhd1mk5o=;
  b=N7ZrHl+DNo766Ojpsss023megAHGLKDkps6JaKyUmOD+kUEO7KIMJoA0
   7qcQoVRyuHugmGO5N/eisxq26mLa77ZoKsbjiIFf6qCNmr13BmwdrL1Iw
   cWccHzqGZfbTKUgXeXrd4QAyyaLO5cB+iR/2qGFH9EUHH1yF8Yu3YOQpc
   /iobogdKThhC8Diyp/w2JoFhUasaHF34sjo+zuUyyAYrISyaLU95oxp7c
   FRUOEnTtE2WoCuKIrbugG6hguPDKjDEx6aqydxFtYUoKYh/l2fiRWpvZy
   mxUQwPYHVpV9Je8l43xgmvC1U6KmPZpP2HEuBK5Wb4p+ECxOWUeqiqQ1y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="310613978"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="310613978"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 23:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="701901429"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="701901429"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 13 Nov 2022 23:43:11 -0800
Date:   Mon, 14 Nov 2022 15:33:48 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/12] mfd: intel-m10-bmc: Downscope SPI related defines
Message-ID: <Y3HvXFhtH/OPbSGu@yilunxu-OptiPlex-7050>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-8-ilpo.jarvinen@linux.intel.com>
 <Y24WDyIPO7NRa8Vg@yilunxu-OptiPlex-7050>
 <93a358e-d590-ae2b-32bc-bdefb58c6bac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93a358e-d590-ae2b-32bc-bdefb58c6bac@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-11 at 13:20:18 +0200, Ilpo Järvinen wrote:
> On Fri, 11 Nov 2022, Xu Yilun wrote:
> 
> > On 2022-11-08 at 16:43:00 +0200, Ilpo Järvinen wrote:
> > > Move SPI related defines to per interface from the global header. This
> > 
> > These definitions are not for SPI, maybe more precisely like "SPI based
> > board definitions".
> > 
> > > makes it harder to shoot oneself into foot.
> > 
> > Maybe better to use plain text in commit message.
> 
> Ok, I'll try to incorporate your suggestions.
> 
> > > Some bitfield defs are also moved to intel-m10-bmc-core which seems
> > > more appropriate for them.
> > 
> > I'm still not clear about the motivation of these movements. For example:
> > 
> > We move the MAC registers in core, then should we also move sec update
> > registers in sec update driver?
> 
> I'd actually prefer to do exactly as you suggest for sec update defines 
> too but it didn't feel like their move would fit well into this patch 
> series.

It's good to me.

> 
> > We move the DOORBELL reg addr out, but keep DOORBELL reg fields in
> > header file, seems make harder for people to get the whole picture.
> 
> Those reg fields are common between boards, no? Unlike the DOORBELL reg 
> addr whose value depends on which interface the board is based on?
> 
> The point of this move is that this header file would without this split
> give a _wrong_ "whole picture" if it keeps the defines that are not
> shared for all boards but vary per interface.

Fine, it's good to me.

Thanks,
Yilun

> 
> But if you still insist, I can of course drop this patch. It's in no way
> absolutely necessary even if I personnally think it's useful to downscope
> defines (but I can understand there might be different opinions such as 
> the one you stated above).
> 
> -- 
>  i.
> 
> 
> > > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel-m10-bmc-core.c  | 11 ++++++++
> > >  drivers/mfd/intel-m10-bmc-spi.c   | 39 +++++++++++++++++++++++++
> > >  include/linux/mfd/intel-m10-bmc.h | 47 -------------------------------
> > >  3 files changed, 50 insertions(+), 47 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> > > index 51b78b868235..50a4ec758bdb 100644
> > > --- a/drivers/mfd/intel-m10-bmc-core.c
> > > +++ b/drivers/mfd/intel-m10-bmc-core.c
> > > @@ -12,6 +12,17 @@
> > >  #include <linux/mfd/intel-m10-bmc.h>
> > >  #include <linux/module.h>
> > >  
> > > +/* Register fields of system registers */
> > > +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> > > +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> > > +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> > > +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> > > +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> > > +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> > > +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
> > > +#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
> > > +#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> > > +
> > >  static ssize_t bmc_version_show(struct device *dev,
> > >  				struct device_attribute *attr, char *buf)
> > >  {
> > > diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> > > index e3b2edb8bc07..4a7a16d9f8d6 100644
> > > --- a/drivers/mfd/intel-m10-bmc-spi.c
> > > +++ b/drivers/mfd/intel-m10-bmc-spi.c
> > > @@ -13,6 +13,45 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/spi/spi.h>
> > >  
> > > +#define M10BMC_LEGACY_BUILD_VER		0x300468
> > > +#define M10BMC_SYS_BASE			0x300800
> > > +#define M10BMC_SYS_END			0x300fff
> > > +#define M10BMC_FLASH_BASE		0x10000000
> > > +#define M10BMC_FLASH_END		0x1fffffff
> > > +#define M10BMC_MEM_END			M10BMC_FLASH_END
> > > +
> > > +#define M10BMC_STAGING_BASE		0x18000000
> > > +
> > > +/* Register offset of system registers */
> > > +#define NIOS2_FW_VERSION		0x0
> > > +#define M10BMC_MAC_LOW			0x10
> > > +#define M10BMC_MAC_HIGH			0x14
> > > +#define M10BMC_TEST_REG			0x3c
> > > +#define M10BMC_BUILD_VER		0x68
> > > +#define M10BMC_VER_LEGACY_INVALID	0xffffffff
> > > +
> > > +/* Secure update doorbell register, in system register region */
> > > +#define M10BMC_DOORBELL			0x400
> > > +
> > > +/* Authorization Result register, in system register region */
> > > +#define M10BMC_AUTH_RESULT		0x404
> > > +
> > > +/* Addresses for security related data in FLASH */
> > > +#define BMC_REH_ADDR	0x17ffc004
> > > +#define BMC_PROG_ADDR	0x17ffc000
> > > +#define BMC_PROG_MAGIC	0x5746
> > > +
> > > +#define SR_REH_ADDR	0x17ffd004
> > > +#define SR_PROG_ADDR	0x17ffd000
> > > +#define SR_PROG_MAGIC	0x5253
> > > +
> > > +#define PR_REH_ADDR	0x17ffe004
> > > +#define PR_PROG_ADDR	0x17ffe000
> > > +#define PR_PROG_MAGIC	0x5250
> > > +
> > > +/* Address of 4KB inverted bit vector containing staging area FLASH count */
> > > +#define STAGING_FLASH_COUNT	0x17ffb000
> > > +
> > >  static const struct regmap_range m10bmc_regmap_range[] = {
> > >  	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> > >  	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> > > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > > index 860408aa8db3..ed920f76d3c8 100644
> > > --- a/include/linux/mfd/intel-m10-bmc.h
> > > +++ b/include/linux/mfd/intel-m10-bmc.h
> > > @@ -15,39 +15,8 @@ enum m10bmc_type {
> > >  	M10_N5010,
> > >  };
> > >  
> > > -#define M10BMC_LEGACY_BUILD_VER		0x300468
> > > -#define M10BMC_SYS_BASE			0x300800
> > > -#define M10BMC_SYS_END			0x300fff
> > > -#define M10BMC_FLASH_BASE		0x10000000
> > > -#define M10BMC_FLASH_END		0x1fffffff
> > > -#define M10BMC_MEM_END			M10BMC_FLASH_END
> > > -
> > > -#define M10BMC_STAGING_BASE		0x18000000
> > >  #define M10BMC_STAGING_SIZE		0x3800000
> > >  
> > > -/* Register offset of system registers */
> > > -#define NIOS2_FW_VERSION		0x0
> > > -#define M10BMC_MAC_LOW			0x10
> > > -#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> > > -#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> > > -#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> > > -#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> > > -#define M10BMC_MAC_HIGH			0x14
> > > -#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> > > -#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> > > -#define M10BMC_MAC_COUNT		GENMASK(23, 16)
> > > -#define M10BMC_TEST_REG			0x3c
> > > -#define M10BMC_BUILD_VER		0x68
> > > -#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
> > > -#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> > > -#define M10BMC_VER_LEGACY_INVALID	0xffffffff
> > > -
> > > -/* Secure update doorbell register, in system register region */
> > > -#define M10BMC_DOORBELL			0x400
> > > -
> > > -/* Authorization Result register, in system register region */
> > > -#define M10BMC_AUTH_RESULT		0x404
> > > -
> > >  /* Doorbell register fields */
> > >  #define DRBL_RSU_REQUEST		BIT(0)
> > >  #define DRBL_RSU_PROGRESS		GENMASK(7, 4)
> > > @@ -108,22 +77,6 @@ enum m10bmc_type {
> > >  #define RSU_COMPLETE_INTERVAL_MS	1000
> > >  #define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
> > >  
> > > -/* Addresses for security related data in FLASH */
> > > -#define BMC_REH_ADDR	0x17ffc004
> > > -#define BMC_PROG_ADDR	0x17ffc000
> > > -#define BMC_PROG_MAGIC	0x5746
> > > -
> > > -#define SR_REH_ADDR	0x17ffd004
> > > -#define SR_PROG_ADDR	0x17ffd000
> > > -#define SR_PROG_MAGIC	0x5253
> > > -
> > > -#define PR_REH_ADDR	0x17ffe004
> > > -#define PR_PROG_ADDR	0x17ffe000
> > > -#define PR_PROG_MAGIC	0x5250
> > > -
> > > -/* Address of 4KB inverted bit vector containing staging area FLASH count */
> > > -#define STAGING_FLASH_COUNT	0x17ffb000
> > > -
> > >  /**
> > >   * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
> > >   */
> > > -- 
> > > 2.30.2
> > > 
> > 

