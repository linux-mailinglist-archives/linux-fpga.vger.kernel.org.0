Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B165905E
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiL2SZM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiL2SYn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 13:24:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1039D13F91;
        Thu, 29 Dec 2022 10:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672338276; x=1703874276;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j6AdErddOqC871Dsa7UuMSnZAJkrT4w35N5022AWvYU=;
  b=QmJ+oCm0F+u2XYmkHDWWpAspxgZSDYRcndhLD1U0L8/NnIqG5KmivaU3
   kgJps3i45qFF2Md/23y7+Iqln/oRF3xU7Ui5Vx0pGW59zpJjGItp1TGYQ
   bokiJFNVzCQPWPi8FzHBLKmS20h6XH/XrjUB1N8ovmHScLi06AODQSzbF
   9MmRd48CYmPQimD5+giGuqCP/3PzkwbzPhFmyp1wQdg6DLXxCNKokO3Vg
   QBhsQIA4U88qReReP/1+5jgXAwZS8viRmAg+HFlP7JDSvaBPYXEt9zDVX
   0U94Ea67zTdR0WJYwrJKLmKxQEIwfEKGQ+Xd/wnCj3h/lxj7Cf3c4H+GW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="308849845"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="308849845"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 10:24:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="899053757"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="899053757"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 10:24:36 -0800
Date:   Thu, 29 Dec 2022 10:25:01 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tom Rix <trix@redhat.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2212290940590.1857691@rhweight-WRK1>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com> <20221228181624.1793433-4-matthew.gerlach@linux.intel.com> <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-611982471-1672338303=:1857691"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-611982471-1672338303=:1857691
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Thu, 29 Dec 2022, Tom Rix wrote:

> On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> 
>> +
>> +	while (params < end) {
>> +		v = *params;
>> +		if (param_id == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
>> +			return params;
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		params += next;
>> +		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
>> +			break;
> Move before next =, and save some work calculating unsed next

Thanks for the suggestion.  Yes, the change will save some work, and the 
code will look better.

>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * dfh_find_param() - find parameter block for the given parameter id
>> + * @dfl_dev: dfl device
>> + * @param: id of dfl parameter
>> + *
>> + * Return: pointer to start of parameter block, NULL otherwise.
>> + */
>> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
>> +{
>> +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
>> +}
>> +EXPORT_SYMBOL_GPL(dfh_find_param);
>
> This and similar should be noop's for dfh v0
>
> Generally there should be better checking if code is running a v1 vs  v0 
> header.

With v0, dfl_dev->params will be NULL and dfl_dev->param_size will be 
zero. Earlier feedback suggested to use the internal NULL/size checking 
instead of adding redundant checks.

>
>> +
>> +/**
>> + * dfh_get_u64_param_vals() - get array of u64 param values for given 
>> parameter id
>> + * @dfl_dev: dfl device
>> + * @param: id of dfl parameter
>> + * @pval: location of parameter data destination
>> + * @nvals: number of u64 elements of parameter data
>> + *
>> + * Return: pointer to start of parameter block, PTR_ERR otherwise
>> + */
>> +u64 *dfh_get_u64_param_vals(struct dfl_device *dfl_dev, int param_id, u64 
>> *pval, int nvals)
> nvals should be unsigned
>> +{
>> +	u64 *param = find_param(dfl_dev->params, dfl_dev->param_size, 
>> param_id);
>> +	u64 next;
>> +	int i;
>> +
>> +	if (!param)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, *param);
>> +
>> +	if (nvals >= next)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	for (i = 0; i < nvals; i++)
>> +		*pval++ = param[i + 1];
> memcpy ?

Yes, memcpy would be better.

>> +
>> +	return param;
>> +}
>> +EXPORT_SYMBOL_GPL(dfh_get_u64_param_vals);
>> +
>>   static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>> -			      resource_size_t ofst, u16 fid,
>> -			      unsigned int *irq_base, unsigned int *nr_irqs)
>> +			      resource_size_t ofst, struct dfl_feature_info 
>> *finfo)
>>   {
>>   	void __iomem *base = binfo->ioaddr + ofst;
>>   	unsigned int i, ibase, inr = 0;
>> +	void *params = finfo->params;
>>   	enum dfl_id_type type;
>> +	u16 fid = finfo->fid;
>>   	int virq;
>> +	u64 *p;
>>   	u64 v;
>>   -	type = feature_dev_id_type(binfo->feature_dev);
>> +	switch (finfo->dfh_version) {
>> +	case 0:
>
> A switch makes this code complicated to read.

Previous feedback suggested a switch statement better than if/else.

>
> Have you thought about a function pointer table to separate out similar v1 vs 
> v0 code blocks?

I haven't though of a function pointer table, and I'm not sure how much 
clearer it would be, but I'll consider it.

>
>> +		/*
>> +		 * DFHv0 only provides MMIO resource information for each 
>> feature
>> +		 * in the DFL header.  There is no generic interrupt 
>> information.
>> +		 * Instead, features with interrupt functionality provide
>> +		 * the information in feature specific registers.
>> +		 */
>> +		type = feature_dev_id_type(binfo->feature_dev);
>> +		if (type == PORT_ID) {
>> +			switch (fid) {
>> +			case PORT_FEATURE_ID_UINT:
>> +				v = readq(base + PORT_UINT_CAP);
>> +				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>> +				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>> +				break;
>> +			case PORT_FEATURE_ID_ERROR:
>> +				v = readq(base + PORT_ERROR_CAP);
>> +				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, 
>> v);
>> +				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>> +				break;
>> +			}
>> +		} else if (type == FME_ID) {
>> +			switch (fid) {
>> +			case FME_FEATURE_ID_GLOBAL_ERR:
>> +				v = readq(base + FME_ERROR_CAP);
>> +				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>> +				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
>> +				break;
>> +			}
>> +		}
>> +		break;
>>   -	/*
>> -	 * Ideally DFL framework should only read info from DFL header, but
>> -	 * current version DFL only provides mmio resources information for
>> -	 * each feature in DFL Header, no field for interrupt resources.
>> -	 * Interrupt resource information is provided by specific mmio
>> -	 * registers of each private feature which supports interrupt. So in
>> -	 * order to parse and assign irq resources, DFL framework has to look
>> -	 * into specific capability registers of these private features.
>> -	 *
>> -	 * Once future DFL version supports generic interrupt resource
>> -	 * information in common DFL headers, the generic interrupt parsing
>> -	 * code will be added. But in order to be compatible to old version
>> -	 * DFL, the driver may still fall back to these quirks.
>> -	 */
>> -	if (type == PORT_ID) {
>> -		switch (fid) {
>> -		case PORT_FEATURE_ID_UINT:
>> -			v = readq(base + PORT_UINT_CAP);
>> -			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>> -			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>> -			break;
>> -		case PORT_FEATURE_ID_ERROR:
>> -			v = readq(base + PORT_ERROR_CAP);
>> -			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>> -			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>> +	case 1:
>> +		/*
>> +		 * DFHv1 provides interrupt resource information in DFHv1
>> +		 * parameter blocks.
>> +		 */
>> +		p = find_param(params, finfo->param_size, 
>> DFHv1_PARAM_ID_MSI_X);
>> +		if (!p)
>>   			break;
>> -		}
>> -	} else if (type == FME_ID) {
>> -		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
>> -			v = readq(base + FME_ERROR_CAP);
>> -			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>> -			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
>> -		}
>> +
>> +		p++;
>> +		ibase = FIELD_GET(DFHv1_PARAM_MSI_X_STARTV, *p);
>> +		inr = FIELD_GET(DFHv1_PARAM_MSI_X_NUMV, *p);
>> +		break;
>> +
>> +	default:
>> +		dev_warn(binfo->dev, "unexpected DFH version %d\n", 
>> finfo->dfh_version);
>> +		break;
>>   	}
>>     	if (!inr) {
>> -		*irq_base = 0;
>> -		*nr_irqs = 0;
>> +		finfo->irq_base = 0;
>> +		finfo->nr_irqs = 0;
>>   		return 0;
>>   	}
>>   @@ -1006,12 +1114,37 @@ static int parse_feature_irqs(struct 
>> build_feature_devs_info *binfo,
>>   		}
>>   	}
>>   -	*irq_base = ibase;
>> -	*nr_irqs = inr;
>> +	finfo->irq_base = ibase;
>> +	finfo->nr_irqs = inr;
>>     	return 0;
>>   }
>>   +static int dfh_get_psize(void __iomem *dfh_base, resource_size_t max)
> for clarity, psize should be expanded to param_size

s/psize/param_size would be clearer and more consistent.

>> +{
>> +	int size = 0;
>> +	u64 v, next;
>> +
>> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
>> +		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
>> +		return 0;
>> +
>> +	while (size + DFHv1_PARAM_HDR < max) {
>> +		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		if (!next)
>> +			return -EINVAL;
>> +
>> +		size += next * sizeof(u64);
>> +
>> +		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
>> +			return size;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>>   /*
>>    * when create sub feature instances, for private features, it doesn't 
>> need
>>    * to provide resource size and feature id as they could be read from DFH
>> @@ -1023,39 +1156,69 @@ static int
>>   create_feature_instance(struct build_feature_devs_info *binfo,
>>   			resource_size_t ofst, resource_size_t size, u16 fid)
>>   {
>> -	unsigned int irq_base, nr_irqs;
>>   	struct dfl_feature_info *finfo;
>> +	resource_size_t start, end;
>> +	int dfh_psize = 0;
>>   	u8 revision = 0;
>> +	u64 v, addr_off;
>> +	u8 dfh_ver = 0;
>>   	int ret;
>> -	u64 v;
>>     	if (fid != FEATURE_ID_AFU) {
>>   		v = readq(binfo->ioaddr + ofst);
>>   		revision = FIELD_GET(DFH_REVISION, v);
>> -
>> +		dfh_ver = FIELD_GET(DFH_VERSION, v);
>>   		/* read feature size and id if inputs are invalid */
>>   		size = size ? size : feature_size(v);
>>   		fid = fid ? fid : feature_id(v);
>> +		if (dfh_ver == 1) {
>> +			dfh_psize = dfh_get_psize(binfo->ioaddr + ofst, 
>> size);
>> +			if (dfh_psize < 0) {
>> +				dev_err(binfo->dev,
>> +					"failed to read size of DFHv1 
>> parameters %d\n",
>> +					dfh_psize);
>> +				return dfh_psize;
>> +			}
>> +			dev_dbg(binfo->dev, "dfhv1_psize %d\n", dfh_psize);
>> +		}
>>   	}
>>     	if (binfo->len - ofst < size)
>>   		return -EINVAL;
>>   -	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
>> -	if (ret)
>> -		return ret;
>> -
>> -	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
>> +	finfo = kzalloc(struct_size(finfo, params, dfh_psize/sizeof(u64)), 
>> GFP_KERNEL);
>>   	if (!finfo)
>>   		return -ENOMEM;
>>   +	memcpy_fromio(finfo->params, binfo->ioaddr + ofst + DFHv1_PARAM_HDR, 
>> dfh_psize);
>> +	finfo->param_size = dfh_psize;
>> +
>>   	finfo->fid = fid;
>>   	finfo->revision = revision;
>> -	finfo->mmio_res.start = binfo->start + ofst;
>> -	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>> +	finfo->dfh_version = dfh_ver;
>> +	if (dfh_ver == 1) {
>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
>> +		addr_off = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
>> +		if (FIELD_GET(DFHv1_CSR_ADDR_REL, v))
>> +			start = addr_off << 1;
>> +		else
>> +			start = binfo->start + ofst + addr_off;
>> +
>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
>> +		end = start + FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
>> +	} else {
>> +		start = binfo->start + ofst;
>> +		end = start + size - 1;
>> +	}
>>   	finfo->mmio_res.flags = IORESOURCE_MEM;
>> -	finfo->irq_base = irq_base;
>> -	finfo->nr_irqs = nr_irqs;
>> +	finfo->mmio_res.start = start;
>> +	finfo->mmio_res.end = end;
>> +
>> +	ret = parse_feature_irqs(binfo, ofst, finfo);
>> +	if (ret) {
>> +		kfree(finfo);
>> +		return ret;
>> +	}
>>     	list_add_tail(&finfo->node, &binfo->sub_features);
>>   	binfo->feature_num++;
>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>> index fc59f33367ee..a21065cec04e 100644
>> --- a/drivers/fpga/dfl.h
>> +++ b/drivers/fpga/dfl.h
>> @@ -111,6 +111,10 @@
>>   #define DFHv1_PARAM_HDR_NEXT_EOP	BIT_ULL(32)
>>   #define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from 
>> Param header */
>>   +#define DFHv1_PARAM_ID_MSI_X		0x1
>> +#define DFHv1_PARAM_MSI_X_NUMV		GENMASK_ULL(63, 32)
>> +#define DFHv1_PARAM_MSI_X_STARTV	GENMASK_ULL(31, 0)
>> +
>>   /* Next AFU Register Bitfield */
>>   #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to 
>> next AFU */
>>   @@ -272,11 +276,14 @@ struct dfl_feature_irq_ctx {
>>    * @ops: ops of this sub feature.
>>    * @ddev: ptr to the dfl device of this sub feature.
>>    * @priv: priv data of this feature.
>> + * @param_size: size of dfh parameters
>> + * @params: point to memory copy of dfh parameters
>>    */
>>   struct dfl_feature {
>>   	struct platform_device *dev;
>>   	u16 id;
>>   	u8 revision;
>> +	u8 dfh_version;
>
> Needs a description in the comments above.

Thanks for catching that.

>
> I am concerned generally about backward compatibility and oot drivers that 
> are dfh v0.

I agree it would be much safter to add the new fields to the end of the 
structure for compatibility reasons. I will do this for struct dfl_device 
as well.

Thanks for the review,
Matthew Gerlach


>
> Adding an element in the middle will break things.
>
> These structures could be more explicit about what is common, and what is v0 
> and v1 specific.
>
> Tom
>
>>   	int resource_index;
>>   	void __iomem *ioaddr;
>>   	struct dfl_feature_irq_ctx *irq_ctx;
>> @@ -284,6 +291,8 @@ struct dfl_feature {
>>   	const struct dfl_feature_ops *ops;
>>   	struct dfl_device *ddev;
>>   	void *priv;
>> +	unsigned int param_size;
>> +	void *params;
>>   };
>>     #define FEATURE_DEV_ID_UNUSED	(-1)
>> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
>> index 431636a0dc78..3138ea42d02e 100644
>> --- a/include/linux/dfl.h
>> +++ b/include/linux/dfl.h
>> @@ -39,9 +39,12 @@ struct dfl_device {
>>   	u16 type;
>>   	u16 feature_id;
>>   	u8 revision;
>> +	u8 dfh_version;
>>   	struct resource mmio_res;
>>   	int *irqs;
>>   	unsigned int num_irqs;
>> +	unsigned int param_size;
>> +	void *params;
>>   	struct dfl_fpga_cdev *cdev;
>>   	const struct dfl_device_id *id_entry;
>>   };
>> @@ -84,4 +87,7 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
>>   	module_driver(__dfl_driver, dfl_driver_register, \
>>   		      dfl_driver_unregister)
>>   +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param);
>> +
>> +u64 *dfh_get_u64_param_vals(struct dfl_device *dfl_dev, int param_id, u64 
>> *pval, int nvals);
>>   #endif /* __LINUX_DFL_H */
>
>
--8323328-611982471-1672338303=:1857691--
