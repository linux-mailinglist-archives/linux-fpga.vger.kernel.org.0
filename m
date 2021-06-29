Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387233B7795
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhF2SIh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 14:08:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:40295 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhF2SIg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 14:08:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="272060875"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="272060875"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 11:06:07 -0700
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="419694967"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 11:06:06 -0700
Date:   Tue, 29 Jun 2021 11:04:22 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 1/4] fpga: dfl: expose feature revision from struct
 dfl_device
In-Reply-To: <20210629121214.988036-2-martin@geanix.com>
Message-ID: <alpine.DEB.2.22.394.2106291103430.1279832@rhweight-WRK1>
References: <20210629121214.988036-1-martin@geanix.com> <20210629121214.988036-2-martin@geanix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-431308998-1624990064=:1279832"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-431308998-1624990064=:1279832
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Tue, 29 Jun 2021, Martin Hundebøll wrote:

> From: Martin Hundebøll <mhu@silicom.dk>
>
> DFL device drivers have a common need for checking feature revision
> information from the DFL header, as well as other common DFL information
> like the already exposed feature id and type.
>
> This patch exposes the feature revision information directly via the DFL
> device data structure.
>
> Since the DFL core code has already read the DFL header, this this patch
> saves additional mmio reads from DFL device drivers too.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>
> Changes since v2:
> * Reworded commit message as per Hao's suggestion
>
> Changes since v1:
> * This patch replaces the previous patch 2 and exposes the feature
>   revision through struct dfl_device instead of a helper reading from
>   io-mem
>
> drivers/fpga/dfl.c  | 27 +++++++++++++++++----------
> drivers/fpga/dfl.h  |  1 +
> include/linux/dfl.h |  1 +
> 3 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 511b20ff35a3..9381c579d1cd 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -381,6 +381,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>
> 	ddev->type = feature_dev_id_type(pdev);
> 	ddev->feature_id = feature->id;
> +	ddev->revision = feature->revision;
> 	ddev->cdev = pdata->dfl_cdev;
>
> 	/* add mmio resource */
> @@ -717,6 +718,7 @@ struct build_feature_devs_info {
>  */
> struct dfl_feature_info {
> 	u16 fid;
> +	u8 rev;
> 	struct resource mmio_res;
> 	void __iomem *ioaddr;
> 	struct list_head node;
> @@ -796,6 +798,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> 		/* save resource information for each feature */
> 		feature->dev = fdev;
> 		feature->id = finfo->fid;
> +		feature->revision = finfo->rev;
>
> 		/*
> 		 * the FIU header feature has some fundamental functions (sriov
> @@ -910,19 +913,17 @@ static void build_info_free(struct build_feature_devs_info *binfo)
> 	devm_kfree(binfo->dev, binfo);
> }
>
> -static inline u32 feature_size(void __iomem *start)
> +static inline u32 feature_size(u64 value)
> {
> -	u64 v = readq(start + DFH);
> -	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, v);
> +	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, value);
> 	/* workaround for private features with invalid size, use 4K instead */
> 	return ofst ? ofst : 4096;
> }
>
> -static u16 feature_id(void __iomem *start)
> +static u16 feature_id(u64 value)
> {
> -	u64 v = readq(start + DFH);
> -	u16 id = FIELD_GET(DFH_ID, v);
> -	u8 type = FIELD_GET(DFH_TYPE, v);
> +	u16 id = FIELD_GET(DFH_ID, value);
> +	u8 type = FIELD_GET(DFH_TYPE, value);
>
> 	if (type == DFH_TYPE_FIU)
> 		return FEATURE_ID_FIU_HEADER;
> @@ -1021,10 +1022,15 @@ create_feature_instance(struct build_feature_devs_info *binfo,
> 	unsigned int irq_base, nr_irqs;
> 	struct dfl_feature_info *finfo;
> 	int ret;
> +	u8 rev;
> +	u64 v;
> +
> +	v = readq(binfo->ioaddr + ofst);
> +	rev = FIELD_GET(DFH_REVISION, v);
>
> 	/* read feature size and id if inputs are invalid */
> -	size = size ? size : feature_size(binfo->ioaddr + ofst);
> -	fid = fid ? fid : feature_id(binfo->ioaddr + ofst);
> +	size = size ? size : feature_size(v);
> +	fid = fid ? fid : feature_id(v);
>
> 	if (binfo->len - ofst < size)
> 		return -EINVAL;
> @@ -1038,6 +1044,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
> 		return -ENOMEM;
>
> 	finfo->fid = fid;
> +	finfo->rev = rev;
> 	finfo->mmio_res.start = binfo->start + ofst;
> 	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
> 	finfo->mmio_res.flags = IORESOURCE_MEM;
> @@ -1166,7 +1173,7 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
> {
> 	if (!is_feature_dev_detected(binfo)) {
> 		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
> -			feature_id(binfo->ioaddr + ofst));
> +			feature_id(readq(binfo->ioaddr + ofst)));
> 		return -EINVAL;
> 	}
>
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96ba56c..422157cfd742 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -243,6 +243,7 @@ struct dfl_feature_irq_ctx {
> struct dfl_feature {
> 	struct platform_device *dev;
> 	u16 id;
> +	u8 revision;
> 	int resource_index;
> 	void __iomem *ioaddr;
> 	struct dfl_feature_irq_ctx *irq_ctx;
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 6cc10982351a..431636a0dc78 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -38,6 +38,7 @@ struct dfl_device {
> 	int id;
> 	u16 type;
> 	u16 feature_id;
> +	u8 revision;
> 	struct resource mmio_res;
> 	int *irqs;
> 	unsigned int num_irqs;
> -- 
> 2.31.0
>
>
--8323328-431308998-1624990064=:1279832--
