Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF25FBEB0
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Oct 2022 02:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJLAbt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Oct 2022 20:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLAbs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Oct 2022 20:31:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC7BA59B7;
        Tue, 11 Oct 2022 17:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665534689; x=1697070689;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vBp0T8+mMqZ1kjBRD3tOy2m6rGI/0HR0qO6g0a13AI4=;
  b=JvlJHlDgLvmn7mMYo50ySIJ8grM5VANM0DLSZMjEXETXMLEexPr8ICGl
   x6cJJn2D8fWFYMrJrgw3+7s634rFlv/2YpV+WM2Q40/TJT3GulpO3hRoN
   r/9JXIC8iz4RqegCGCGzshZGtIAlNX2mmlv/xfJp236cLrqTl2TqAY1Sz
   f7t3IR12hed6pVMQGzosx9xkXBYhn39/ciyxRG8CIwzwY8nkJ06Nz4Em8
   3NO+JsaAx+pK49G+VaoT9rAvNwcLFSXSL405VAO8v+uk7Bg81KWwaRHzD
   CAXHOP9EZgdHweqI6gguoNYeQWCT2wuHlHLXrRU01X/aFk3DoZ0hvUXJq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="302271800"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="302271800"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 17:31:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="715720437"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="715720437"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 17:31:05 -0700
Date:   Tue, 11 Oct 2022 17:31:18 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y0UM87Tkq0VfBVJn@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2210111644500.2511705@rhweight-WRK1>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-4-matthew.gerlach@linux.intel.com> <Yz6ffEeKZButHw4m@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2210100937280.2404672@rhweight-WRK1>
 <Y0UM87Tkq0VfBVJn@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 11 Oct 2022, Xu Yilun wrote:

> On 2022-10-10 at 09:58:00 -0700, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Thu, 6 Oct 2022, Xu Yilun wrote:
>>
>>> On 2022-10-04 at 07:37:17 -0700, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Add generic support for MSIX interrupts for DFL devices.
>>>>
>>>> The location of a feature's registers is explicitly
>>>> described in DFHv1 and can be relative to the base of the DFHv1
>>>> or an absolute address.  Parse the location and pass the information
>>>> to DFL driver.
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> ---
>>>> v3: remove unneeded blank line
>>>>     use clearer variable name
>>>>     pass finfo into parse_feature_irqs()
>>>>     refactor code for better indentation
>>>>     use switch statement for irq parsing
>>>>     squash in code parsing register location
>>>>
>>>> v2: fix kernel doc
>>>>     clarify use of DFH_VERSION field
>>>> ---
>>>>  drivers/fpga/dfl.c  | 150 ++++++++++++++++++++++++++++++++------------
>>>>  drivers/fpga/dfl.h  |   3 +
>>>>  include/linux/dfl.h |  20 ++++++
>>>>  3 files changed, 134 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>>>> index b9aae85ba930..6a74317e549e 100644
>>>> --- a/drivers/fpga/dfl.c
>>>> +++ b/drivers/fpga/dfl.c
>>>> @@ -380,7 +380,11 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>>>>  	ddev->type = feature_dev_id_type(pdev);
>>>>  	ddev->feature_id = feature->id;
>>>>  	ddev->revision = feature->revision;
>>>> +	ddev->dfh_version = feature->dfh_version;
>>>>  	ddev->cdev = pdata->dfl_cdev;
>>>> +	ddev->csr_res.start = feature->csr_res.start;
>>>> +	ddev->csr_res.end = feature->csr_res.end;
>>>> +	ddev->csr_res.flags = IORESOURCE_MEM;
>>>>
>>>>  	/* add mmio resource */
>>>>  	parent_res = &pdev->resource[feature->resource_index];
>>>> @@ -708,18 +712,24 @@ struct build_feature_devs_info {
>>>>   * struct dfl_feature_info - sub feature info collected during feature dev build
>>>>   *
>>>>   * @fid: id of this sub feature.
>>>> + * @revision: revision of this sub feature
>>>> + * @dfh_version: version of Device Feature Header (DFH)
>>>>   * @mmio_res: mmio resource of this sub feature.
>>>>   * @ioaddr: mapped base address of mmio resource.
>>>>   * @node: node in sub_features linked list.
>>>> + * @csr_res: resource of DFHv1 feature registers
>>>> + * @csr_size: DFHv1 size of feature registers
>>>>   * @irq_base: start of irq index in this sub feature.
>>>>   * @nr_irqs: number of irqs of this sub feature.
>>>>   */
>>>>  struct dfl_feature_info {
>>>>  	u16 fid;
>>>>  	u8 revision;
>>>> +	u8 dfh_version;
>>>>  	struct resource mmio_res;
>>>>  	void __iomem *ioaddr;
>>>>  	struct list_head node;
>>>> +	struct resource csr_res;
>>>>  	unsigned int irq_base;
>>>>  	unsigned int nr_irqs;
>>>>  };
>>>> @@ -797,6 +807,9 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>>>>  		feature->dev = fdev;
>>>>  		feature->id = finfo->fid;
>>>>  		feature->revision = finfo->revision;
>>>> +		feature->dfh_version = finfo->dfh_version;
>>>> +		feature->csr_res.start = finfo->csr_res.start;
>>>> +		feature->csr_res.end = finfo->csr_res.end;
>>>>
>>>>  		/*
>>>>  		 * the FIU header feature has some fundamental functions (sriov
>>>> @@ -935,55 +948,74 @@ static u16 feature_id(u64 value)
>>>>  }
>>>>
>>>>  static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>>>> -			      resource_size_t ofst, u16 fid,
>>>> -			      unsigned int *irq_base, unsigned int *nr_irqs)
>>>> +			      resource_size_t ofst, struct dfl_feature_info *finfo)
>>>>  {
>>>>  	void __iomem *base = binfo->ioaddr + ofst;
>>>>  	unsigned int i, ibase, inr = 0;
>>>>  	enum dfl_id_type type;
>>>> -	int virq;
>>>> -	u64 v;
>>>> -
>>>> -	type = feature_dev_id_type(binfo->feature_dev);
>>>> +	u16 fid = finfo->fid;
>>>> +	u64 v, dfh_ver;
>>>> +	int virq, off;
>>>>
>>>>  	/*
>>>>  	 * Ideally DFL framework should only read info from DFL header, but
>>>> -	 * current version DFL only provides mmio resources information for
>>>> +	 * current version, DFHv0, only provides mmio resources information for
>>>>  	 * each feature in DFL Header, no field for interrupt resources.
>>>>  	 * Interrupt resource information is provided by specific mmio
>>>>  	 * registers of each private feature which supports interrupt. So in
>>>>  	 * order to parse and assign irq resources, DFL framework has to look
>>>>  	 * into specific capability registers of these private features.
>>>>  	 *
>>>> -	 * Once future DFL version supports generic interrupt resource
>>>> -	 * information in common DFL headers, the generic interrupt parsing
>>>> -	 * code will be added. But in order to be compatible to old version
>>>> +	 * DFHv1 supports generic interrupt resource information in DFHv1
>>>> +	 * parameter blocks. But in order to be compatible to old version
>>>>  	 * DFL, the driver may still fall back to these quirks.
>>>>  	 */
>>>> -	if (type == PORT_ID) {
>>>> -		switch (fid) {
>>>> -		case PORT_FEATURE_ID_UINT:
>>>> -			v = readq(base + PORT_UINT_CAP);
>>>> -			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>>>> -			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>>>> +
>>>> +	switch (finfo->dfh_version) {
>>>> +	case 0:
>>>> +		type = feature_dev_id_type(binfo->feature_dev);
>>>> +		if (type == PORT_ID) {
>>>> +			switch (fid) {
>>>> +			case PORT_FEATURE_ID_UINT:
>>>> +				v = readq(base + PORT_UINT_CAP);
>>>> +				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>>>> +				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>>>> +				break;
>>>> +			case PORT_FEATURE_ID_ERROR:
>>>> +				v = readq(base + PORT_ERROR_CAP);
>>>> +				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>>>> +				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>>>> +				break;
>>>> +			}
>>>> +		} else if (type == FME_ID) {
>>>> +			if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
>>>> +				v = readq(base + FME_ERROR_CAP);
>>>> +				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>>>> +				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
>>>> +			}
>>>> +		}
>>>> +		break;
>>>> +
>>>> +	case 1:
>>>> +		if (!dfhv1_has_params(base))
>>>>  			break;
>>>> -		case PORT_FEATURE_ID_ERROR:
>>>> -			v = readq(base + PORT_ERROR_CAP);
>>>> -			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>>>> -			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>>>> +
>>>> +		off = dfhv1_find_param(base, ofst, DFHv1_PARAM_ID_MSIX);
>>>> +		if (off < 0)
>>>>  			break;
>>>> -		}
>>>> -	} else if (type == FME_ID) {
>>>> -		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
>>>> -			v = readq(base + FME_ERROR_CAP);
>>>> -			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>>>> -			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
>>>> -		}
>>>> +
>>>> +		ibase = readl(base + off + DFHv1_PARAM_MSIX_STARTV);
>>>> +		inr = readl(base + off + DFHv1_PARAM_MSIX_NUMV);
>>>> +		break;
>>>> +
>>>> +	default:
>>>> +		dev_warn(binfo->dev, "unexpected DFH version %lld\n", dfh_ver);
>>>> +		break;
>>>>  	}
>>>>
>>>>  	if (!inr) {
>>>> -		*irq_base = 0;
>>>> -		*nr_irqs = 0;
>>>> +		finfo->irq_base = 0;
>>>> +		finfo->nr_irqs = 0;
>>>>  		return 0;
>>>>  	}
>>>>
>>>> @@ -1006,8 +1038,8 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>>>>  		}
>>>>  	}
>>>>
>>>> -	*irq_base = ibase;
>>>> -	*nr_irqs = inr;
>>>> +	finfo->irq_base = ibase;
>>>> +	finfo->nr_irqs = inr;
>>>>
>>>>  	return 0;
>>>>  }
>>>> @@ -1023,8 +1055,8 @@ static int
>>>>  create_feature_instance(struct build_feature_devs_info *binfo,
>>>>  			resource_size_t ofst, resource_size_t size, u16 fid)
>>>>  {
>>>> -	unsigned int irq_base, nr_irqs;
>>>>  	struct dfl_feature_info *finfo;
>>>> +	u8 dfh_version = 0;
>>>>  	u8 revision = 0;
>>>>  	int ret;
>>>>  	u64 v;
>>>> @@ -1032,7 +1064,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>>>>  	if (fid != FEATURE_ID_AFU) {
>>>>  		v = readq(binfo->ioaddr + ofst);
>>>>  		revision = FIELD_GET(DFH_REVISION, v);
>>>> -
>>>> +		dfh_version = FIELD_GET(DFH_VERSION, v);
>>>>  		/* read feature size and id if inputs are invalid */
>>>>  		size = size ? size : feature_size(v);
>>>>  		fid = fid ? fid : feature_id(v);
>>>> @@ -1041,21 +1073,33 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>>>>  	if (binfo->len - ofst < size)
>>>>  		return -EINVAL;
>>>>
>>>> -	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>>  	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
>>>>  	if (!finfo)
>>>>  		return -ENOMEM;
>>>>
>>>>  	finfo->fid = fid;
>>>>  	finfo->revision = revision;
>>>> +	finfo->dfh_version = dfh_version;
>>>>  	finfo->mmio_res.start = binfo->start + ofst;
>>>>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>>>>  	finfo->mmio_res.flags = IORESOURCE_MEM;
>>>> -	finfo->irq_base = irq_base;
>>>> -	finfo->nr_irqs = nr_irqs;
>>>> +
>>>> +	ret = parse_feature_irqs(binfo, ofst, finfo);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (dfh_version == 1) {
>>>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
>>>> +		if (v & DFHv1_CSR_ADDR_REL)
>>>> +			finfo->csr_res.start = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
>>>> +		else
>>>> +			finfo->csr_res.start = binfo->start + ofst
>>>> +					       + FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
>>>> +
>>>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
>>>> +		finfo->csr_res.end = finfo->csr_res.start
>>>> +				     + FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
>>>> +	}
>>>>
>>>>  	list_add_tail(&finfo->node, &binfo->sub_features);
>>>>  	binfo->feature_num++;
>>>> @@ -1879,6 +1923,34 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(dfl_feature_ioctl_set_irq);
>>>>
>>>> +int dfhv1_find_param(void __iomem *base, resource_size_t max, int param)
>>>> +{
>>>> +	int off = DFHv1_PARAM_HDR;
>>>> +	u64 v, next;
>>>> +
>>>> +	while (off < max) {
>>>> +		v = readq(base + off);
>>>> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
>>>> +			return (DFHv1_PARAM_DATA + off);
>>>> +
>>>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>>>> +		if (!next)
>>>> +			break;
>>>> +
>>>> +		off += next;
>>>> +	}
>>>> +
>>>> +	return -ENOENT;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dfhv1_find_param);
>>>> +
>>>> +int dfhv1_has_params(void __iomem *dfh_base)
>>>> +{
>>>> +	return (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
>>>> +		readq(dfh_base + DFHv1_CSR_SIZE_GRP)));
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dfhv1_has_params);
>>>> +
>>>>  static void __exit dfl_fpga_exit(void)
>>>>  {
>>>>  	dfl_chardev_uinit();
>>>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>>>> index bd8720bc5320..0423aa8319ed 100644
>>>> --- a/drivers/fpga/dfl.h
>>>> +++ b/drivers/fpga/dfl.h
>>>> @@ -266,6 +266,7 @@ struct dfl_feature_irq_ctx {
>>>>   *		    this index is used to find its mmio resource from the
>>>>   *		    feature dev (platform device)'s resources.
>>>>   * @ioaddr: mapped mmio resource address.
>>>> + * @csr_res: resource for DFHv1 feature registers
>>>>   * @irq_ctx: interrupt context list.
>>>>   * @nr_irqs: number of interrupt contexts.
>>>>   * @ops: ops of this sub feature.
>>>> @@ -276,8 +277,10 @@ struct dfl_feature {
>>>>  	struct platform_device *dev;
>>>>  	u16 id;
>>>>  	u8 revision;
>>>> +	u8 dfh_version;
>>>>  	int resource_index;
>>>>  	void __iomem *ioaddr;
>>>> +	struct resource csr_res;
>>>>  	struct dfl_feature_irq_ctx *irq_ctx;
>>>>  	unsigned int nr_irqs;
>>>>  	const struct dfl_feature_ops *ops;
>>>> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
>>>> index 1a1a2b894687..71760c6a25d7 100644
>>>> --- a/include/linux/dfl.h
>>>> +++ b/include/linux/dfl.h
>>>> @@ -39,6 +39,7 @@ enum dfl_id_type {
>>>>   * @type: type of DFL FIU of the device. See enum dfl_id_type.
>>>>   * @feature_id: feature identifier local to its DFL FIU type.
>>>>   * @mmio_res: mmio resource of this dfl device.
>>>> + * @csr_res: resource for DFHv1 feature registers
>>>
>>> I think the combination of mmio_res & csr_res is confusing. Why a
>>> special csr_res dedicated for DFHv1, and what the mmio_res stands for if
>>> the csr_res exists? And they may overlap each other.
>>
>> With DFHv1, the registers of a feature may be in a different location than
>> the location of the Device Feature Header.  So a resource is needed for the
>> DFH and another resource for the actual register space.  Would changing the
>> name of mmio_res to dfh_res be less confusing? Unfortunately, changing the
>> name of mmio_res would impact the existing dfl drivers.
>
> There are 4 existing dfl drivers now, I think making changes is still
> possible. But what is more important to me is to have a clear definition
> of resource layout for dfl_device structure, cause it is used in other kernel
> domains. Resource overlapping is hard to understand.

I agree that we need to have a clear definition of resource layout for 
dfl_device structure, and resource overlapping is hard to understand.

>
> Some possible options in my mind:
> 1. keep the mmio_res, but it only includes the csr region.
>
>   dfl driver couldn't access dfl header & param directly, but I think
>   it's OK, dfl drivers don't have to care too much about the HW layout
>   of dfl header & param. The header & param values could be parsed in dfl
>   core and provided to dfl drivers by APIs.
>
>   No extension of multiple csr regions in future.
>
> 2. struct resource mmio_res -> int num_mmio_res & struct resource *mmio_res
>
>   Same as platform device, multiple resources for multiple memory blocks,
>   maybe each tagged by name, they don't overlap each other. It impacts the
>   existing dfl drivers, but may support multiple csr regions if possible.
>

I think we may need a combination of both of your suggested options. I 
think a limitation to a single memory resource will be insufficient for 
many IP blocks.  DFL drivers do need to know things in header like 
parameters and feature revisions, but I agree they can be parsed out and 
dfl drivers can access the information by APIs.

>>
>> The two resources may overlap, but that is why in
>> drivers/tty/serial/8250/8250_dfl.c the mmio_res is mapped, then DFH parsed,
>> and unmapped before the csr_res is mapped in the call to
>> serial8250_register_8250_port().
>
> This is what I want to avoid, every dfl driver needs the same routine
> for the mmios they really want, which is a challenge to all domain
> reviewers.

I understand your concern. Let's try to get this concern fully addressed.

>
> Thanks,
> Yilun
>
>>
>>>
>>> Could you present some general purpose mmio resource layout which is
>>> compatible to dfl v0 & v1? People from other domains just need to know
>>> the basic concept like how many register blocks in the device, what are
>>> their ranges ...
>>
>> I don't know how a single resource object can be used in the case of DFHv1
>> when the registers are in a different location than the DFH.
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>
