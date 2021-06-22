Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9343A3B1030
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 00:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFVWo3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 18:44:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:31153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhFVWo2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 18:44:28 -0400
IronPort-SDR: kujRSxSvBzxiAOleu3PQmf2hko3lLi0aqmdSrweWMWyw368SOvsGqLMnXhf7S1MTYTbDw1qZXg
 6eEJ4bWnlyPA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="271000264"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="271000264"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:42:11 -0700
IronPort-SDR: 222/b6NYmxBS18Q++ORUFFnhUFK7UtsSSR05EIp5FJJH429THmlY4rvITiufQr0jLMqG0P8jya
 qLi/kT44p5xA==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="406114025"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.27.104])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:42:10 -0700
Subject: Re: [PATCH v6 1/3] fpga: mgr: Use standard dev_release for class
 driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210621222249.451387-1-russell.h.weight@intel.com>
 <20210621222249.451387-2-russell.h.weight@intel.com>
 <20210622084515.GB29169@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <aaf09ea9-6ae3-c055-1f1d-060883c6682a@intel.com>
Date:   Tue, 22 Jun 2021 15:41:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622084515.GB29169@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/22/21 1:45 AM, Xu Yilun wrote:
> Some more comments.
>
> On Mon, Jun 21, 2021 at 03:22:47PM -0700, Russ Weight wrote:
>> +struct fpga_manager *
>> +fpga_mgr_register(struct device *parent, struct fpga_manager_info *info)
>>  {
>> +	const struct fpga_manager_ops *mops = info->mops;
>>  	struct fpga_manager *mgr;
>>  	int id, ret;
>>  
>> @@ -572,29 +570,31 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
> Shall we add the check?

It's already there in the line before the context that is shown.

>
> 	if (!mops || ...)
>
>>  	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>>  	    (mops->write && mops->write_sg)) {
>>  		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
>> -		return NULL;
>> +		return ERR_PTR(-EINVAL);
>>  	}
>>  
>>
> [...]
>   
>> +struct fpga_manager *
>> +fpga_mgr_register(struct device *dev, struct fpga_manager_info *info);
> 		     struct device *parent, const struct fpga_manager_info
Yes - I'll fix all of the prototypes.

Thanks,
- Russ

>
>>  
>> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
>> +struct fpga_manager *
>> +fpga_mgr_register_simple(struct device *dev, const char *name,
> 			    struct device *parent,
>
>> +			 const struct fpga_manager_ops *mops, void *priv);
>> +void fpga_mgr_unregister(struct fpga_manager *mgr);
>>  
>> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
>> -					  const struct fpga_manager_ops *mops,
>> -					  void *priv);
>> +struct fpga_manager *
>> +devm_fpga_mgr_register(struct device *dev, struct fpga_manager_info *info);
>
> 			  struct device *parent, const struct fpga_manager_info
>
>> +struct fpga_manager *
>> +devm_fpga_mgr_register_simple(struct device *dev, const char *name,
> 				 struct device *parent,
>
>> +			      const struct fpga_manager_ops *mops, void *priv);
>>  
>>  #endif /*_LINUX_FPGA_MGR_H */
>> -- 
>> 2.25.1

