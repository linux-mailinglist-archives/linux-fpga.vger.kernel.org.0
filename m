Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183985E805D
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIWRG3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIWRG3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 13:06:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633614A7BE;
        Fri, 23 Sep 2022 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663952787; x=1695488787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZCjIgHYGCH7WpacNcOYdFFzz/xvTzjVdh8YXbYg2xC0=;
  b=Ou4qCBIweqBVIgYcnC1B1tNYl/WLMuzKQBPdmmsE8w1cdilQWSjcvfSr
   2CWMyVdmVy/u50Ys1Qug61RHa+odYXdLxC2sUWNchAAxQj6jL6CNd+jDA
   Gu+DerPxBobq8dMOLOEcz9Ha9kLXkjPUx8EhSrT5gs0f0MV44YyCqSJKp
   ACI4qZN8KeNng8X+52tE4w0IuPUls3OPoZqoV1jT+NfBeSP6CgGDyNvuH
   VhHS3G/2kpMv3LnUCUeGYNyX/V3a8VKRRKiy6lyKl4kxBClFIrkmTbRsv
   K3Ne5UM26dX6zWdu5JxwuAEgWx1VQDFfGElNNuK9bVGe1BEn8+UbnEVxs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="302085971"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="302085971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:06:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="571439005"
Received: from bmuddebi-mobl.amr.corp.intel.com (HELO [10.209.43.107]) ([10.209.43.107])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:06:26 -0700
Message-ID: <0a5ec2cc-239b-9685-9bbf-7e8a7eacd10f@linux.intel.com>
Date:   Fri, 23 Sep 2022 10:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 5/6] fpga: dfl: parse the location of the feature's
 registers from DFHv1
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Matthew Gerlach <matthew.gerlach@intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
 <20220923121745.129167-6-matthew.gerlach@linux.intel.com>
From:   "Muddebihal, Basheer Ahmed" 
        <basheer.ahmed.muddebihal@linux.intel.com>
In-Reply-To: <20220923121745.129167-6-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/23/2022 5:17 AM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@intel.com>
> 
> The location of a feature's registers is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: Introduced in v2.
> ---
>  drivers/fpga/dfl.c  | 26 +++++++++++++++++++++++++-
>  drivers/fpga/dfl.h  |  4 ++++
>  include/linux/dfl.h |  4 ++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index dfd3f563c92d..6fb4f30f93cf 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -381,6 +381,8 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>  	ddev->feature_id = feature->id;
>  	ddev->revision = feature->revision;
>  	ddev->cdev = pdata->dfl_cdev;
> +	ddev->csr_start = feature->csr_start;
> +	ddev->csr_size = feature->csr_size;
>  
>  	/* add mmio resource */
>  	parent_res = &pdev->resource[feature->resource_index];
> @@ -708,18 +710,25 @@ struct build_feature_devs_info {
>   * struct dfl_feature_info - sub feature info collected during feature dev build
>   *
>   * @fid: id of this sub feature.
> + * @revision: revision of this sub feature
> + * @dfh_version: version of Device Feature Header (DFH)
>   * @mmio_res: mmio resource of this sub feature.
>   * @ioaddr: mapped base address of mmio resource.
>   * @node: node in sub_features linked list.
> + * @csr_start: DFHv1 start of feature registers
> + * @csr_size: DFHv1 size of feature registers
>   * @irq_base: start of irq index in this sub feature.
>   * @nr_irqs: number of irqs of this sub feature.
>   */
>  struct dfl_feature_info {
>  	u16 fid;
>  	u8 revision;
> +	u8 dfh_version;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
> +	resource_size_t csr_start;
> +	resource_size_t csr_size;
>  	unsigned int irq_base;
>  	unsigned int nr_irqs;
>  };
> @@ -797,6 +806,8 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  		feature->dev = fdev;
>  		feature->id = finfo->fid;
>  		feature->revision = finfo->revision;> +		feature->csr_start = finfo->csr_start;
> +		feature->csr_size = finfo->csr_size;
>  
>  		/*
>  		 * the FIU header feature has some fundamental functions (sriov
> @@ -1054,6 +1065,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  {
>  	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
> +	u8 dfh_version = 0;
>  	u8 revision = 0;
>  	int ret;
>  	u64 v;
> @@ -1061,7 +1073,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	if (fid != FEATURE_ID_AFU) {
>  		v = readq(binfo->ioaddr + ofst);
>  		revision = FIELD_GET(DFH_REVISION, v);
> -
> +		dfh_version = FIELD_GET(DFH_VERSION, v);
>  		/* read feature size and id if inputs are invalid */
>  		size = size ? size : feature_size(v);
>  		fid = fid ? fid : feature_id(v);
> @@ -1080,12 +1092,24 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  
>  	finfo->fid = fid;
>  	finfo->revision = revision;
> +	finfo->dfh_version = dfh_version;
>  	finfo->mmio_res.start = binfo->start + ofst;
>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
>  	finfo->irq_base = irq_base;
>  	finfo->nr_irqs = nr_irqs;
>  
> +	if (dfh_version == 1) {
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
> +		if (v & DFHv1_CSR_ADDR_REL)
> +			finfo->csr_start = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> +		else
> +			finfo->csr_start = binfo->start + ofst + FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> +
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
> +		finfo->csr_size = FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v);
> +	}
> +
>  	list_add_tail(&finfo->node, &binfo->sub_features);
>  	binfo->feature_num++;
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index e620fcb02b5a..64cedd00dca4 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -217,6 +217,8 @@ struct dfl_feature_irq_ctx {
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s resources.
>   * @ioaddr: mapped mmio resource address.
> + * @csr_start: DFHv1 start of feature registers
> + * @csr_size: DFHv1 size of feature registers
>   * @irq_ctx: interrupt context list.
>   * @nr_irqs: number of interrupt contexts.
>   * @ops: ops of this sub feature.
> @@ -229,6 +231,8 @@ struct dfl_feature {
>  	u8 revision;
>  	int resource_index;
>  	void __iomem *ioaddr;
> +	resource_size_t csr_start;
> +	resource_size_t csr_size;
>  	struct dfl_feature_irq_ctx *irq_ctx;
>  	unsigned int nr_irqs;
>  	const struct dfl_feature_ops *ops;
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 33e21c360671..7d74ef8d1d20 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -84,6 +84,8 @@ enum dfl_id_type {
>   * @type: type of DFL FIU of the device. See enum dfl_id_type.
>   * @feature_id: feature identifier local to its DFL FIU type.
>   * @mmio_res: mmio resource of this dfl device.
> + * @csr_start: DFHv1 start of feature registers
> + * @csr_size: DFHv1 size of feature registers
>   * @irqs: list of Linux IRQ numbers of this dfl device.
>   * @num_irqs: number of IRQs supported by this dfl device.
>   * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> @@ -96,6 +98,8 @@ struct dfl_device {
>  	u16 feature_id;
>  	u8 revision;
> +	u8 dfh_version;

This is already parsed as part of info dfl_feature_info, Can we add dfh_version to store it for further use ? 

>  	struct resource mmio_res;
> +	resource_size_t csr_start;
> +	resource_size_t csr_size;
>  	int *irqs;
>  	unsigned int num_irqs;
>  	struct dfl_fpga_cdev *cdev;
