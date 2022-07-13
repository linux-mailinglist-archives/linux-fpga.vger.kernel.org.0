Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D9573CEA
	for <lists+linux-fpga@lfdr.de>; Wed, 13 Jul 2022 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiGMTGs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 13 Jul 2022 15:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiGMTGs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 13 Jul 2022 15:06:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135D2CE16;
        Wed, 13 Jul 2022 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657739207; x=1689275207;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KHsybcTTtmSjs79flHrFsftHV7qrjOVYH+3rw2fKiEM=;
  b=UFJZIRswcaiVQdOQeZk4q1op5sURCc7cd7taL+Q/wRFII/dFl0javkCm
   jRpFIef1acOkaULnj0sTm6A0GtKGiAq4R6q+ZfYsY06wzr9rIDa5dfmww
   oGPZihmo/+WrM6av2PNuiwwko560OysIA++P3X1Dw0GSuobyZf5+5EJC5
   b4/eu3PoVJU2Cic0Ed9HH/p/nlZ3STVDG+L3BpBQ6IhbqmqZNa172U6rK
   bHl3zkNcbF97AxbEwjPzYwLHzTfLBs6Ux5N9lK4gxMmyvqbshJCkZ6FH5
   vYvxV3yefUzMAWmNKJJlrWdaTdSkcfyhgcf+AOIdv5RZ7HXcl9+ISqy3P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="310965300"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="310965300"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 12:06:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="922763254"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 12:06:46 -0700
Date:   Wed, 13 Jul 2022 12:06:39 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tianfei Zhang <tianfei.zhang@intel.com>
cc:     ssantosh@kernel.org, krzysztof.kozlowski@linaro.org,
        trix@redhat.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Debarati Biswas <debaratix.biswas@intel.com>
Subject: Re: [PATCH v2] memory: dfl-emif: Update the dfl emif driver support
 revision 1
In-Reply-To: <20220713130355.196115-1-tianfei.zhang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2207131205440.639047@rhweight-WRK1>
References: <20220713130355.196115-1-tianfei.zhang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 13 Jul 2022, Tianfei Zhang wrote:

> From: Debarati Biswas <debaratix.biswas@intel.com>
>
> The next generation (revision 1) of the DFL EMIF feature device requires
> support for more than 4 memory banks. It does not support the selective
> clearing of memory banks. A capability register replaces the previous
> control register, and contains a bitmask to indicate the presence of each
> memory bank. This bitmask aligns with the previous control register
> bitmask that served the same purpose. The control and capability
> registers are treated like a C Union structure in order to support both
> the new and old revisions of the EMIF device.
>
> Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

> ---
> v2: no code change, just rebased to v5.19-rc6.
> ---
> drivers/memory/dfl-emif.c | 62 +++++++++++++++++++++++++++++++++++----
> 1 file changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/memory/dfl-emif.c b/drivers/memory/dfl-emif.c
> index 3f719816771d..da06cd30a016 100644
> --- a/drivers/memory/dfl-emif.c
> +++ b/drivers/memory/dfl-emif.c
> @@ -24,11 +24,24 @@
> #define EMIF_STAT_CLEAR_BUSY_SFT	16
> #define EMIF_CTRL			0x10
> #define EMIF_CTRL_CLEAR_EN_SFT		0
> -#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(3, 0)
> +#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(7, 0)
>
> #define EMIF_POLL_INVL			10000 /* us */
> #define EMIF_POLL_TIMEOUT		5000000 /* us */
>
> +/*
> + * The Capability Register replaces the Control Register (at the same
> + * offset) for EMIF feature revisions > 0. The bitmask that indicates
> + * the presence of memory channels exists in both the Capability Register
> + * and Control Register definitions. These can be thought of as a C union.
> + * The Capability Register definitions are used to check for the existence
> + * of a memory channel, and the Control Register definitions are used for
> + * managing the memory-clear functionality in revision 0.
> + */
> +#define EMIF_CAPABILITY_BASE		0x10
> +#define EMIF_CAPABILITY_CHN_MSK_V0	GENMASK_ULL(3, 0)
> +#define EMIF_CAPABILITY_CHN_MSK		GENMASK_ULL(7, 0)
> +
> struct dfl_emif {
> 	struct device *dev;
> 	void __iomem *base;
> @@ -106,16 +119,30 @@ emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 0);
> emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 1);
> emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 2);
> emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 3);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 4);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 5);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 6);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 7);
>
> emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 0);
> emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 1);
> emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 2);
> emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 3);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 4);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 5);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 6);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 7);
> +
>
> emif_clear_attr(0);
> emif_clear_attr(1);
> emif_clear_attr(2);
> emif_clear_attr(3);
> +emif_clear_attr(4);
> +emif_clear_attr(5);
> +emif_clear_attr(6);
> +emif_clear_attr(7);
> +
>
> static struct attribute *dfl_emif_attrs[] = {
> 	&emif_attr_inf0_init_done.attr.attr,
> @@ -134,6 +161,22 @@ static struct attribute *dfl_emif_attrs[] = {
> 	&emif_attr_inf3_cal_fail.attr.attr,
> 	&emif_attr_inf3_clear.attr.attr,
>
> +	&emif_attr_inf4_init_done.attr.attr,
> +	&emif_attr_inf4_cal_fail.attr.attr,
> +	&emif_attr_inf4_clear.attr.attr,
> +
> +	&emif_attr_inf5_init_done.attr.attr,
> +	&emif_attr_inf5_cal_fail.attr.attr,
> +	&emif_attr_inf5_clear.attr.attr,
> +
> +	&emif_attr_inf6_init_done.attr.attr,
> +	&emif_attr_inf6_cal_fail.attr.attr,
> +	&emif_attr_inf6_clear.attr.attr,
> +
> +	&emif_attr_inf7_init_done.attr.attr,
> +	&emif_attr_inf7_cal_fail.attr.attr,
> +	&emif_attr_inf7_clear.attr.attr,
> +
> 	NULL,
> };
>
> @@ -143,15 +186,24 @@ static umode_t dfl_emif_visible(struct kobject *kobj,
> 	struct dfl_emif *de = dev_get_drvdata(kobj_to_dev(kobj));
> 	struct emif_attr *eattr = container_of(attr, struct emif_attr,
> 					       attr.attr);
> +	struct dfl_device *ddev = to_dfl_dev(de->dev);
> 	u64 val;
>
> 	/*
> -	 * This device supports upto 4 memory interfaces, but not all
> +	 * This device supports up to 8 memory interfaces, but not all
> 	 * interfaces are used on different platforms. The read out value of
> -	 * CLEAN_EN field (which is a bitmap) could tell how many interfaces
> -	 * are available.
> +	 * CAPABILITY_CHN_MSK field (which is a bitmap) indicates which
> +	 * interfaces are available.
> 	 */
> -	val = FIELD_GET(EMIF_CTRL_CLEAR_EN_MSK, readq(de->base + EMIF_CTRL));
> +	if (ddev->revision > 0 && strstr(attr->name, "_clear"))
> +		return 0;
> +
> +	if (ddev->revision == 0)
> +		val = FIELD_GET(EMIF_CAPABILITY_CHN_MSK_V0,
> +				readq(de->base + EMIF_CAPABILITY_BASE));
> +	else
> +		val = FIELD_GET(EMIF_CAPABILITY_CHN_MSK,
> +				readq(de->base + EMIF_CAPABILITY_BASE));
>
> 	return (val & BIT_ULL(eattr->index)) ? attr->mode : 0;
> }
> -- 
> 2.26.2
>
>
