Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0611030338C
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 05:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbhAZE6V (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 23:58:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:47497 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbhAZCDd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 21:03:33 -0500
IronPort-SDR: 2FL3CYhY3uEP/JmRw9FbXnJX5h/W6USOqlvL6CtltOpWqG0ZtE26sPsUFPkyW020rx2+C3kHI8
 gRk+aX04hmxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="166933633"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="166933633"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 17:55:57 -0800
IronPort-SDR: ZHgMOGhms3lDsGr039E0x4fU1thOqihYdvFLU1PrBvdWAhTdipQqJxInTFCzDdZPiiOYQiJ2xo
 PWvH24BnMadw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="356565382"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2021 17:55:56 -0800
Subject: Re: [PATCHv3 1/6] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
 <4e1c60e6-8e6e-d0c6-970f-674958ffe91d@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <f6f90796-c845-4549-741a-cda9b38bd695@linux.intel.com>
Date:   Mon, 25 Jan 2021 20:16:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4e1c60e6-8e6e-d0c6-970f-674958ffe91d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On 1/25/21 4:56 PM, Tom Rix wrote:
> 
> On 1/25/21 12:56 PM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
>> authentication feature. Authenticating a bitstream is to make sure a signed
>> bitstream has the valid signatures.
>>
>> Except for the actual configuration of the device, the bitstream
>> authentication works the same way as FPGA configuration does. If the
>> authentication passes, the signed bitstream will be programmed into QSPI
>> flash memory and will be expected to boot without issues.
>>
>> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
>> aligns with the firmware settings.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v3: no change
>> v2: new added
>> ---
>>   include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>> index ebc2956..7ada1f2 100644
>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>> @@ -51,12 +51,17 @@
>>   #define SVC_STATUS_NO_SUPPORT		6
>>   
>>   /*
> 
> This patch fails to apply, i believe the conflict is because in mainline this is '/**' not '/*'
> 
> Please check or point me at the branch/tag you are using.
> 

I am using next-20210125 tag.

> I am using char-misc-next.
> 
> Tom
> 
> Tom
> 
Regards,
Richard
