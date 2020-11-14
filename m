Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2072B2DA8
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Nov 2020 15:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNObU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Nov 2020 09:31:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:16596 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKNObU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 14 Nov 2020 09:31:20 -0500
IronPort-SDR: qGkj36N2c4Cm2fa//Of5IsATL6FzDPTnsXXmR19STNhGjGZwCl9Dzz2RARy9dwGj/XMwq7yZnL
 WF6tczc9xVFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="149850383"
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="149850383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 06:31:19 -0800
IronPort-SDR: VKXYe8yYrXRimHNtMlYCMY7e8yCiS8OCDIT32NLRh3auO6jyACzDWjVPzO2JguqcKy0KnaYDnV
 p8TYBAomD8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="324306438"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2020 06:31:19 -0800
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <94ccfc8d-ecf9-7782-9044-d3c0cb862118@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <e7b815c1-e153-2bed-7793-0affd4d74f9e@linux.intel.com>
Date:   Sat, 14 Nov 2020 08:52:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <94ccfc8d-ecf9-7782-9044-d3c0cb862118@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On 11/13/20 2:28 PM, Tom Rix wrote:
> 
> On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add authenticate-fpga-config property for FPGA bitstream authentication.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> index e811cf8..7a512bc 100644
>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> @@ -187,6 +187,7 @@ Optional properties:
>>   - external-fpga-config : boolean, set if the FPGA has already been configured
>>   	prior to OS boot up.
>>   - encrypted-fpga-config : boolean, set if the bitstream is encrypted
>> +- authenticate-fpga-config : boolean, set if do bitstream authentication
> 
> The list is mostly in alphabetical order so the new 'authenticate-... ' should go at the top.
> 

The original list is not in alphabetical order. The order of 
partial-fpga-config, external-fpga-config and encrypted-fpga-config here 
follows the implementation in the of-fpga-region.c file.

So authenticate-fpga-config should follow the way, correct?

> Improve what you mean by 'authentication' similar to my comment in the first patch.
> 

Will do in the version 2 submission.

Regards,
Richard

> Tom
> 
>>   - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>>   	bridges to successfully become enabled after the region has been
>>   	programmed.
> 
