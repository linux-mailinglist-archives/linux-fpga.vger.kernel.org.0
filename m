Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10165B693
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Jan 2023 19:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjABSYi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Jan 2023 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABSYh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 2 Jan 2023 13:24:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3FAE61;
        Mon,  2 Jan 2023 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672683876; x=1704219876;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FYxGH9Ph+n77uzV1dLGl69MdPA8nU2VvfHoq8OrT4zU=;
  b=NEnzzPPeBeFDHVp4mhDJ21tdaasbz5M+pSBNBOkaD8uLYVhyarN+iC5Y
   GHNnmcAQr83thw7LyJQbmmOhqGgN3D/5jyaSx5BhBxoNhPWu/aBm2jXUc
   2ZZjxZl2qtYslZoXEAvZDqAu/PyxQS1h5Y8v42GGztJXDk11maZuci8b+
   DpN50FGbzhOZXI+wCd3FnHgV0LkIGT7bslIt11OjCdn1pnZORNu7LVZLc
   b0YHzerMqw6H52oE2sqv56M8wcObDGJxoyk2A5HeD6s5eCDbKCRkX1q9c
   aKkoZAS2gy2w6BHJBrH2Qa/VZdzkUSrRaUniGD49j+pPCwlLan+HnvQfy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301898999"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="301898999"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 10:24:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="723029911"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="723029911"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 10:24:35 -0800
Date:   Mon, 2 Jan 2023 10:25:00 -0800 (PST)
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
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y66uB8/xj+YF4oEr@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2301021021350.2536944@rhweight-WRK1>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com> <20221228181624.1793433-4-matthew.gerlach@linux.intel.com> <Y66uB8/xj+YF4oEr@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-860723572-1672683901=:2536944"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-860723572-1672683901=:2536944
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 30 Dec 2022, Xu Yilun wrote:

> On 2022-12-28 at 10:16:23 -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Version 1 of the Device Feature Header (DFH) definition adds
>> functionality to the DFL bus.
>>
>> A DFHv1 header may have one or more parameter blocks that
>> further describes the HW to SW.  Add support to the DFL bus
>> to parse the MSI-X parameter.
>>
>> The location of a feature's register set is explicitly
>> described in DFHv1 and can be relative to the base of the DFHv1
>> or an absolute address.  Parse the location and pass the information
>> to DFL driver.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>> v8: use struct_size() from overflow.h
>>     add dfh_get_u64_param_vals()
>
> Could you help check my comments?
> https://lore.kernel.org/linux-fpga/alpine.DEB.2.22.394.2212211421210.570436@rhweight-WRK1/T/#md86e3836130ebacd3c088f5c512ba741aac8a4d1


Sorry I missed your earlier comments. I have since responded to them 
specificially.


>
> [...]
>
>>
>> +static u64 *find_param(u64 *params, resource_size_t max, int param_id)
>> +{
>> +	u64 *end = params + max / sizeof(u64);
>> +	u64 v, next;
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
> Didn't find where to use it?

I understand. Don't export a function unless there is a comsumer for it.

>
>> +
>> +/**
>> + * dfh_get_u64_param_vals() - get array of u64 param values for given parameter id
>
> There is no rule to say one u64 for each property in the parameter block.
> So I don't see the reason for DFL core to provide u64 array for the API,
> And the size of the parameter block is decided by HW, why make the user
> input the value?
>
> As we discussed before, dfl core doesn't try to look into the parameter
> block. So please just provide the const void *data & data_size for drivers.
> This is the most common way to represent a data block.

I will move the parameter parsing helper function to the driver itself.

Thanks for the feedback,
Matthew Gerlach

>
> Thanks,
> Yilun
>
>> + * @dfl_dev: dfl device
>> + * @param: id of dfl parameter
>> + * @pval: location of parameter data destination
>> + * @nvals: number of u64 elements of parameter data
>> + *
>> + * Return: pointer to start of parameter block, PTR_ERR otherwise
>> + */
>> +u64 *dfh_get_u64_param_vals(struct dfl_device *dfl_dev, int param_id, u64 *pval, int nvals)
>> +{
>> +	u64 *param = find_param(dfl_dev->params, dfl_dev->param_size, param_id);
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
>> +
>> +	return param;
>> +}
>> +EXPORT_SYMBOL_GPL(dfh_get_u64_param_vals);
>> +
>
--8323328-860723572-1672683901=:2536944--
