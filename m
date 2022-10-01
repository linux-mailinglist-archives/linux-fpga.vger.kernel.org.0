Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F45F1CF8
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Oct 2022 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJAOuh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 1 Oct 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJAOuf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 1 Oct 2022 10:50:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1007C18E;
        Sat,  1 Oct 2022 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664635834; x=1696171834;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wdofohhhk+WBis7eTbKpBgNiOGZ4pD2blf+gOm7Wz7M=;
  b=KmEZmN9FLxS9/0pgcwN6jV1iYNun8qrUzcPoU1HopQRwm/5yD5tMYWTA
   Fy0jAlUBKRIuYLsJ/t7LF90IiMA9+5tIRgD+5QBWjti7zbsFbEvZWu2uP
   a66IqVLxUZV7EYbGfb7wgw3mv2yMsdgiue8+BYqjusxbYtonMpQT81d41
   Dqvfx+FAhudwtRNvOh7HQ0N0SxzZgb9EX3mMbXVluwVGaSM6F2CUa3u2a
   ipf88+cSBOWs55hyur8oG15zqg0spt62oE0FymXnPVE5WlG7Pvk/ZkFaJ
   bqdEHdVKgX1xYFNt3dM7WYvETXGINaHEzPpsjilFK7rEKbsLIP8jp91J0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="302364788"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="302364788"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 07:50:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="798265388"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="798265388"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 07:50:33 -0700
Date:   Sat, 1 Oct 2022 07:50:43 -0700 (PDT)
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
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <YzZiZsc3X0Iy6Z5S@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2210010749440.1720354@rhweight-WRK1>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-5-matthew.gerlach@linux.intel.com> <YzZiZsc3X0Iy6Z5S@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Fri, 30 Sep 2022, Xu Yilun wrote:

> On 2022-09-23 at 05:17:43 -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Define and use a DFHv1 parameter to add generic support for MSIX
>> interrupts for DFL devices.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v2: fix kernel doc
>>     clarify use of DFH_VERSION field
>> ---
>>  drivers/fpga/dfl.c  | 60 +++++++++++++++++++++++++++++++++++++++++----
>>  include/linux/dfl.h | 14 +++++++++++
>>  2 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>> index 1132f3c10440..dfd3f563c92d 100644
>> --- a/drivers/fpga/dfl.c
>> +++ b/drivers/fpga/dfl.c
>> @@ -941,23 +941,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>>  	void __iomem *base = binfo->ioaddr + ofst;
>>  	unsigned int i, ibase, inr = 0;
>>  	enum dfl_id_type type;
>> -	int virq;
>> +	int virq, off;
>>  	u64 v;
>>
>>  	type = feature_dev_id_type(binfo->feature_dev);
>>
>>  	/*
>>  	 * Ideally DFL framework should only read info from DFL header, but
>> -	 * current version DFL only provides mmio resources information for
>> +	 * current version, DFHv0, only provides mmio resources information for
>
> With this patchset, it's not 'current version' anymore.

I will update the comment. Thanks.

>
>>  	 * each feature in DFL Header, no field for interrupt resources.
>>  	 * Interrupt resource information is provided by specific mmio
>>  	 * registers of each private feature which supports interrupt. So in
>>  	 * order to parse and assign irq resources, DFL framework has to look
>>  	 * into specific capability registers of these private features.
>>  	 *
>> -	 * Once future DFL version supports generic interrupt resource
>> -	 * information in common DFL headers, the generic interrupt parsing
>> -	 * code will be added. But in order to be compatible to old version
>> +	 * DFHv1 supports generic interrupt resource information in DFHv1
>> +	 * parameter blocks. But in order to be compatible to old version
>>  	 * DFL, the driver may still fall back to these quirks.
>>  	 */
>>  	if (type == PORT_ID) {
>> @@ -981,6 +980,36 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>>  		}
>>  	}
>>
>> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
>> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
>> +
>> +		v = FIELD_GET(DFH_VERSION, readq(base));
>> +		switch (v) {
>> +		case 0:
>> +			break;
>
> In last version, you mentioned that there will be no quirk for DFLv1, so
> how about:
>
>  v = FIELD_GET(DFH_VERSION, readq(base));
>
>  if (v == 0) {
> 	/* quirks */
>  } else {
> 	/* parse PARAM MSIX  */
>  }
>
> No need to check specific feature ids again.

With v3 changes I will use a switch state and not need quirks for v1.

>
> Thanks,
> Yilun
>
>> +
>> +		case 1:
>> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
>> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
>> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
>> +						     DFHv1_PARAM_ID_MSIX);
>> +				if (off >= 0) {
>> +					ibase = readl(base + DFHv1_PARAM_HDR +
>> +						      off + DFHv1_PARAM_MSIX_STARTV);
>> +					inr = readl(base + DFHv1_PARAM_HDR +
>> +						    off + DFHv1_PARAM_MSIX_NUMV);
>> +					dev_dbg(binfo->dev, "start %d num %d fid 0x%x\n",
>> +						ibase, inr, fid);
>> +				}
>> +			}
>> +			break;
>> +
>> +		default:
>> +			dev_warn(binfo->dev, "unexpected DFH version %lld\n", v);
>> +			break;
>> +		}
>> +	}
>> +
>>  	if (!inr) {
>>  		*irq_base = 0;
>>  		*nr_irqs = 0;
>> @@ -1879,6 +1908,27 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>>  }
>>  EXPORT_SYMBOL_GPL(dfl_feature_ioctl_set_irq);
>>
>> +int dfl_find_param(void __iomem *base, resource_size_t max, int param)
>> +{
>> +	int off = 0;
>> +	u64 v, next;
>> +
>> +	while (off < max) {
>> +		v = readq(base + off);
>> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
>> +			return off;
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		if (!next)
>> +			break;
>> +
>> +		off += next;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +EXPORT_SYMBOL_GPL(dfl_find_param);
>> +
>>  static void __exit dfl_fpga_exit(void)
>>  {
>>  	dfl_chardev_uinit();
>> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
>> index 1e53468ba8d8..33e21c360671 100644
>> --- a/include/linux/dfl.h
>> +++ b/include/linux/dfl.h
>> @@ -63,6 +63,10 @@
>>  #define DFHv1_PARAM_HDR_VERSION		GENMASK_ULL(31, 16) /* Version Param */
>>  #define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 32) /* Offset of next Param */
>>
>> +#define DFHv1_PARAM_ID_MSIX	0x1
>> +#define DFHv1_PARAM_MSIX_STARTV	0x8
>> +#define DFHv1_PARAM_MSIX_NUMV	0xc
>> +
>>  /**
>>   * enum dfl_id_type - define the DFL FIU types
>>   */
>> @@ -136,4 +140,14 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
>>  	module_driver(__dfl_driver, dfl_driver_register, \
>>  		      dfl_driver_unregister)
>>
>> +/**
>> + * dfl_find_param() - find the offset of the given parameter
>> + * @base: base pointer to start of dfl parameters in DFH
>> + * @max: maximum offset to search
>> + * @param: id of dfl parameter
>> + *
>> + * Return: positive offset on success, negative error code otherwise.
>> + */
>> +int dfl_find_param(void __iomem *base, resource_size_t max, int param);
>> +
>>  #endif /* __LINUX_DFL_H */
>> --
>> 2.25.1
>>
>
