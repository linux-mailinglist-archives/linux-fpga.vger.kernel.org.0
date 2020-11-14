Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C451F2B2D9F
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Nov 2020 15:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNOJp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Nov 2020 09:09:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:45068 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNOJp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 14 Nov 2020 09:09:45 -0500
IronPort-SDR: uwa6VSrk/3ZwiCnOokEQVVcuk+BxJGAzjjgNcQpl8mhulGG5BiJTyVlWXb4pD49meRJ4AipW2S
 COTifjCRMtDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="158356870"
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="158356870"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 06:09:43 -0800
IronPort-SDR: zooRDkVrUhPS8aNedLDU0wkZEuJyiCERpRuI90+Q/8fD5kCH9bX01c6KPHaoD4yonH9F46G98j
 PeMOKbhi7s1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="324301841"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2020 06:09:43 -0800
Subject: Re: [PATCHv1 1/4] fpga: fpga-mgr: add
 FPGA_MGR_BITSTREM_AUTHENTICATION flag
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-2-git-send-email-richard.gong@linux.intel.com>
 <a71b7a9c-effa-ad01-4fde-3e1a1e517e2d@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <4dd9a747-05f3-1cca-22a6-35681677223d@linux.intel.com>
Date:   Sat, 14 Nov 2020 08:30:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a71b7a9c-effa-ad01-4fde-3e1a1e517e2d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

Thanks for review!

On 11/13/20 2:24 PM, Tom Rix wrote:
> 
> On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add FPGA_MGR_BITSTREM_AUTHENTICATION flag for FPGA bitstream
>> authentication.
> 
> Should improve this commit so explain what you mean authentication.
> 
> it could mean 'it wrote correctly' or 'it was signed correctly' or something else.
> 

Authentication = make sure a signed bitstream has valid signatures 
before committing it to QSPI memory. I will update the commit messages 
in version 2.

>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   include/linux/fpga/fpga-mgr.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index 2bc3030..1d65814 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -67,12 +67,15 @@ enum fpga_mgr_states {
>>    * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>>    *
>>    * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
>> + *
>> + * %FPGA_MGR_BITSTREM_AUTHENTICATION: do FPGA bitstream authentication
>>    */
>>   #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>>   #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
>>   #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
>>   #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
>>   #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
>> +#define FPGA_MGR_BITSTREM_AUTHENTICATION BIT(5)
> 
> A whitespace issue, the new BIT(5) should align with the others, so add two spaces to the others.
> 

There is only one space, also I ran checkpatch with strict option and 
didn't see any whitespace issue.

In the original patch, BIT(0) to BIT(4) align themselves. I am not sure 
why we see differently in email.

  #define FPGA_MGR_PARTIAL_RECONFIG      BIT(0)
  #define FPGA_MGR_EXTERNAL_CONFIG       BIT(1)
  #define FPGA_MGR_ENCRYPTED_BITSTREAM   BIT(2)
  #define FPGA_MGR_BITSTREAM_LSB_FIRST   BIT(3)
  #define FPGA_MGR_COMPRESSED_BITSTREAM  BIT(4)
+#define FPGA_MGR_BITSTREM_AUTHENTICATION BIT(5)

To align BIT(5) with others, I have to use additional tab to BIT(0) to 
BIT(4). But I don't think I should make such change on them, agree?

Regards,
Richard

> Tom
> 
>>   
>>   /**
>>    * struct fpga_image_info - information specific to a FPGA image
> 
