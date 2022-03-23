Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206A4E57CA
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Mar 2022 18:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbiCWRqh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Mar 2022 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiCWRqg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Mar 2022 13:46:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93ED6EB3A;
        Wed, 23 Mar 2022 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648057506; x=1679593506;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NCWVugIzR4LXdQtjJlb1q/cqx0VTEXBYJ+E77MstKbc=;
  b=Kt3sau7t4UVEx7MQuTQB5reAHiY9X3SO4j7Bxk2bykUHYcGXlaVKatIY
   YCwvSooIKuxWXGdPhxP0cuyZWor5oWBu4x67uFe7BUPoLJjmzFiPBnqWX
   9AfOHMpEcdAkhDHRH3MzCgIDDB/PQPdC63trGK+fUpoxa7XEcfR1dTvwd
   4jGKvcuWZgZI3EM3iMWXi7phFCi9rcVTx1KnqamxqCl7vwZ80Ar+KIOqx
   smKtIWGKkQrYhgvnK2tQ2ryg+wsjorwWmTHPDrHpHAAPO2CI1XoxNTP7+
   VE616YE++hJVDQF8EBwkjkV7xoFXMFeMbGJyodhqXs50zSzLuMShZsZQ/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="321384640"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="321384640"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 10:45:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="647569488"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 10:45:06 -0700
Date:   Wed, 23 Mar 2022 10:47:13 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tianfei Zhang <tianfei.zhang@intel.com>
cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org
Subject: Re: [PATCH v5 1/2] fpga: dfl: check feature type before parse irq
 info
In-Reply-To: <20220323085102.2297964-2-tianfei.zhang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2203231046240.1238697@rhweight-WRK1>
References: <20220323085102.2297964-1-tianfei.zhang@intel.com> <20220323085102.2297964-2-tianfei.zhang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 23 Mar 2022, Tianfei Zhang wrote:

> From: Tianfei zhang <tianfei.zhang@intel.com>

Hi Tianfei,

Your fix is much better than mine.


>
> Previously the feature IDs defined are unique, no matter
> which feature type. But currently we want to extend its
> usage to have a per-type feature ID space, so this patch
> adds feature type checking as well just before look into
> feature ID for different features which have irq info.
>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4:
>  - Fix the git commit from Hao's comments.
>  - Split documentation into another patch.
> v3:
>  - Remove "Fixes" in commit log with Hao's comment, this is a
>    extension not a bug fix.
> v2:
>  - add DFL Feature ID Registry in documentation.
> ---
> drivers/fpga/dfl.c | 38 ++++++++++++++++++++++----------------
> 1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..6bff39ff21a0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> {
> 	void __iomem *base = binfo->ioaddr + ofst;
> 	unsigned int i, ibase, inr = 0;
> +	enum dfl_id_type type;
> 	int virq;
> 	u64 v;
>
> +	type = feature_dev_id_type(binfo->feature_dev);
> +
> 	/*
> 	 * Ideally DFL framework should only read info from DFL header, but
> 	 * current version DFL only provides mmio resources information for
> @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> 	 * code will be added. But in order to be compatible to old version
> 	 * DFL, the driver may still fall back to these quirks.
> 	 */
> -	switch (fid) {
> -	case PORT_FEATURE_ID_UINT:
> -		v = readq(base + PORT_UINT_CAP);
> -		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> -		break;
> -	case PORT_FEATURE_ID_ERROR:
> -		v = readq(base + PORT_ERROR_CAP);
> -		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> -		break;
> -	case FME_FEATURE_ID_GLOBAL_ERR:
> -		v = readq(base + FME_ERROR_CAP);
> -		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		break;
> +	if (type == PORT_ID) {
> +		switch (fid) {
> +		case PORT_FEATURE_ID_UINT:
> +			v = readq(base + PORT_UINT_CAP);
> +			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +			break;
> +		case PORT_FEATURE_ID_ERROR:
> +			v = readq(base + PORT_ERROR_CAP);
> +			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +			break;
> +		}
> +	} else if (type == FME_ID) {
> +		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> +			v = readq(base + FME_ERROR_CAP);
> +			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		}
> 	}
>
> 	if (!inr) {
> -- 
> 2.26.2
>
>
