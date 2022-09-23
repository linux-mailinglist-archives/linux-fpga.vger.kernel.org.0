Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83D5E7DC2
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIWO4D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWO4C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 10:56:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB78E3EF7;
        Fri, 23 Sep 2022 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663944960; x=1695480960;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xT7yQQlMI8i1XEshe1ZI4ZUk0EILHNHDnZDc2Vgflc4=;
  b=bZ2WtHr/KzHZHPIV0qBxaIqSSsONtYY0DCGhR4PSLXVcFfGRN2wfpg/O
   aXouCK0rlJh7W2kH2A8lyKDZzv/oYN8VUib9kcLazHIgZ4A63rRwaJ8Ri
   eptLiWPZTP5YaqrT1FmMIpW5WVmP3/PUJ+2D7OinhwQzoww7+48TTAAIP
   jkzQSq7ogEMbVit3Iev+EuGMkohV6c/8BmJGQvq+aBEwblq+gCAjYwf6E
   2hz8c4HHX6nHDDvP+6YlM3K3xAtruIPV86krwyvm8kSHw+re8ZHMtgHvk
   4jg78JLQveq+uF+LECwURHFqWvBiCboQnkRLo6IPK/gIcQYPAOWkugNSR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="364626046"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="364626046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:55:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="620234672"
Received: from alutz-mobl.ger.corp.intel.com ([10.252.35.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:55:54 -0700
Date:   Fri, 23 Sep 2022 17:55:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Matthew Gerlach <matthew.gerlach@intel.com>
Subject: Re: [PATCH v2 5/6] fpga: dfl: parse the location of the feature's
 registers from DFHv1
In-Reply-To: <20220923121745.129167-6-matthew.gerlach@linux.intel.com>
Message-ID: <5ce7d953-9289-bb2d-79c-2e5669373a35@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-6-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:

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
>  		feature->revision = finfo->revision;
> +		feature->csr_start = finfo->csr_start;
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

Ordering here seems slightly odd. If finfo would be built before calling
parse_feature_irqs(), it could be passed into there and there would be no 
need to:
- read version for second time
- pass irq_base & nr_irqs as pointer parameters

-- 
 i.
