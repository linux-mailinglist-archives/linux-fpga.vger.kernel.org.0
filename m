Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223A3B1055
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 01:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVXIO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 19:08:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:15558 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVXIN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 19:08:13 -0400
IronPort-SDR: fsV2xlBOXNAw50U3dGdTcHP/qzKIC1rj0wcc/XEpUzUA0Hfsxzy0yFNHTpEtueJlkfYaMda4oQ
 lBTGViGFig0g==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194297939"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="194297939"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:05:53 -0700
IronPort-SDR: b9z+FFihEheI9w6+h1OfXCJvEHC9nWuMPB2aIjfj39kdHjt33JbXqcwgG7w0qwY9n9bMA+UHX/
 dU4MNoHWDJhw==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="406120457"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.27.104])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:05:53 -0700
Subject: Re: [PATCH v6 2/3] fpga: bridge: Use standard dev_release for class
 driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210621222249.451387-1-russell.h.weight@intel.com>
 <20210621222249.451387-3-russell.h.weight@intel.com>
 <20210622082301.GA29169@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <7fdea841-dad0-8b73-0313-3a1c3dfaa17f@intel.com>
Date:   Tue, 22 Jun 2021 16:05:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622082301.GA29169@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/22/21 1:23 AM, Xu Yilun wrote:
> 2 more comments.
>
> On Mon, Jun 21, 2021 at 03:22:48PM -0700, Russ Weight wrote:
>> The FPGA bridge class driver data structure is being treated as a
>> managed resource instead of using standard dev_release call-back
>> to release the class data structure. This change removes the
>> managed resource code and combines the create() and register()
>> functions into a single register() function.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v6:
>>   - Changed fpga_bridge_register() parameters to accept an info data
>>     structure to provide flexibility in passing optional parameters.
>>   - Added fpga_bridge_register_simple() function to support current
>>     parameters for users that don't require the use of optional
>>     parameters.
> Add the _simple() description in commit message if needed.
>
>> +struct fpga_bridge *
>> +fpga_bridge_register_simple(struct device *dev, const char *name,
> 			       struct device *parent,

Yes - I'll make these changes.

Thanks,
- Russ
>
>> +			    const struct fpga_bridge_ops *br_ops,
>> +			    void *priv);
>> +void fpga_bridge_unregister(struct fpga_bridge *br);
>>  
>>  #endif /* _LINUX_FPGA_BRIDGE_H */
>> -- 
>> 2.25.1

