Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33CC664707
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Jan 2023 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjAJRFv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Jan 2023 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjAJRFk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Jan 2023 12:05:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E749164;
        Tue, 10 Jan 2023 09:05:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C8D2B817C2;
        Tue, 10 Jan 2023 17:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47779C433EF;
        Tue, 10 Jan 2023 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673370332;
        bh=428SHNtP/aK3b0mFyPSZRcW3HGKYcmwE0kS9Px1yAD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJx68YRZ6BeWB3nO82v/0hCpESKKIxyP0EfGWvoNb+ImickZnAhnm1r+5dLUtSqqi
         tJOphYFUdmNe0a/afhtQhFWaxK90K8/bsGBPManrR+DyyMGINjk4MLcSDGLBNDewIR
         VOemJ7fTqpaZwx6jNO59RLyRLzdhBdP/J0mqzXnlRaf1t3oSy28qbz71MD9L6Q5yz9
         iKLvwmwFsVV2/iGJWsEDUT4Pq1nLPaR+iISDm32aT8D1OZ2GPjs0JLlUpZDRpza0ND
         0I3RxyNjoV70rKLyan0756EvYmXl9/K9f6cqKOeXVD/RwkcPSpqYdAz2vgdpsFoHvr
         JMLePj5KLENaQ==
Date:   Tue, 10 Jan 2023 17:05:25 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/10] mfd: intel-m10-bmc: Downscope SPI defines &
 prefix with M10BMC_N3000
Message-ID: <Y72a1feFIAMyrVpQ@google.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-7-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-7-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 26 Dec 2022, Ilpo Järvinen wrote:

> Move SPI based board definitions to per interface file from the global
> header. This makes it harder to use them accidently in the
> generic/interface agnostic code. Prefix the defines with M10BMC_N3000
> to make it more obvious these are related to some board type. All
> current non-N3000 board types have the same layout so they'll be
> reused.
> 
> Some bitfield defs are also moved to intel-m10-bmc-core which seems
> more appropriate for them.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc-core.c  | 11 ++++
>  drivers/mfd/intel-m10-bmc-spi.c   | 89 ++++++++++++++++++++++---------
>  include/linux/mfd/intel-m10-bmc.h | 46 ----------------
>  3 files changed, 74 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> index 51b78b868235..50a4ec758bdb 100644
> --- a/drivers/mfd/intel-m10-bmc-core.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -12,6 +12,17 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  
> +/* Register fields of system registers */
> +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
> +#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
> +#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> +
>  static ssize_t bmc_version_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> index e8986154e965..04c83f9c6492 100644
> --- a/drivers/mfd/intel-m10-bmc-spi.c
> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> @@ -13,10 +13,47 @@
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> +#define M10BMC_N3000_LEGACY_BUILD_VER	0x300468
> +#define M10BMC_N3000_SYS_BASE		0x300800
> +#define M10BMC_N3000_SYS_END		0x300fff
> +#define M10BMC_N3000_FLASH_BASE		0x10000000
> +#define M10BMC_N3000_FLASH_END		0x1fffffff
> +#define M10BMC_N3000_MEM_END		M10BMC_N3000_FLASH_END
> +
> +/* Register offset of system registers */
> +#define NIOS2_FW_VERSION		0x0
> +#define M10BMC_N3000_MAC_LOW		0x10
> +#define M10BMC_N3000_MAC_HIGH		0x14
> +#define M10BMC_N3000_TEST_REG		0x3c
> +#define M10BMC_N3000_BUILD_VER		0x68
> +#define M10BMC_N3000_VER_LEGACY_INVALID	0xffffffff
> +
> +/* Secure update doorbell register, in system register region */
> +#define M10BMC_N3000_DOORBELL		0x400
> +
> +/* Authorization Result register, in system register region */
> +#define M10BMC_N3000_AUTH_RESULT		0x404
> +
> +/* Addresses for security related data in FLASH */
> +#define M10BMC_N3000_BMC_REH_ADDR	0x17ffc004
> +#define M10BMC_N3000_BMC_PROG_ADDR	0x17ffc000
> +#define M10BMC_N3000_BMC_PROG_MAGIC	0x5746
> +
> +#define M10BMC_N3000_SR_REH_ADDR	0x17ffd004
> +#define M10BMC_N3000_SR_PROG_ADDR	0x17ffd000
> +#define M10BMC_N3000_SR_PROG_MAGIC	0x5253
> +
> +#define M10BMC_N3000_PR_REH_ADDR	0x17ffe004
> +#define M10BMC_N3000_PR_PROG_ADDR	0x17ffe000
> +#define M10BMC_N3000_PR_PROG_MAGIC	0x5250

My preference would definitely be to keep these blocks of defines tucked
away inside a header file somewhere.

Premise of the change looks fine, however.

-- 
Lee Jones [李琼斯]
