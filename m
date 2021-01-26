Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A735303E72
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 14:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbhAZNTl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 08:19:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:50758 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404612AbhAZNTd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 08:19:33 -0500
IronPort-SDR: 3f1JZxQJxG+Dp8Xkib9grhHnukRzRqpHivAz6FO8dBM+gPo9P4GlXceTy0tq+UVGsYGZ2lQxc2
 GWHAxSgU49qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179978668"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179978668"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 05:17:59 -0800
IronPort-SDR: rm/S14D+nSxvHVdpwPN+uQFhI8WYzo69c1+Gg4RGaNvJbVxWx1EH2d8OkSdl5C8rB14Lepn7bP
 gVwSsogOIj4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="356720721"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2021 05:17:58 -0800
Subject: Re: [PATCHv3 3/6] fpga: fpga-mgr: add
 FPGA_MGR_BITSTREM_AUTHENTICATION flag
To:     Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-4-git-send-email-richard.gong@linux.intel.com>
 <YA+iyFi4lQWPgkTQ@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <cfbcf19c-bb76-59f2-5401-8ab242b9e02e@linux.intel.com>
Date:   Tue, 26 Jan 2021 07:38:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA+iyFi4lQWPgkTQ@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 1/25/21 11:04 PM, Moritz Fischer wrote:
> On Mon, Jan 25, 2021 at 02:56:25PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add FPGA_MGR_BITSTREM_AUTHENTICATION flag for FPGA bitstream
>> authentication, which makes sure a signed bitstream has valid signatures.
>>
>> Except for the actual configuration of the device, the authentication works
>> the same way as FPGA configuration does. If the authentication passes, the
>> bitstream will be programmed into QSPI flash and will be expected to boot
>> without issues.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v3: no change
>> v2: align all FPGA_MGR_* flags
>>      update the commit messages
>> ---
>>   include/linux/fpga/fpga-mgr.h | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index 2bc3030..4fb3400 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -67,12 +67,15 @@ enum fpga_mgr_states {
>>    * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>>    *
>>    * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
>> + *
>> + * %FPGA_MGR_BITSTREM_AUTHENTICATION: do FPGA bitstream authentication only
>>    */
>> -#define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>> -#define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
>> -#define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
>> -#define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
>> -#define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
>> +#define FPGA_MGR_PARTIAL_RECONFIG		BIT(0)
>> +#define FPGA_MGR_EXTERNAL_CONFIG		BIT(1)
>> +#define FPGA_MGR_ENCRYPTED_BITSTREAM		BIT(2)
>> +#define FPGA_MGR_BITSTREAM_LSB_FIRST		BIT(3)
>> +#define FPGA_MGR_COMPRESSED_BITSTREAM		BIT(4)
>> +#define FPGA_MGR_BITSTREM_AUTHENTICATION	BIT(5)
> Consider FPGA_MGR_BITSTREAM_AUTHENTICATE (and fix typo)

Thanks, I will correct that in next submission.

>>   
>>   /**
>>    * struct fpga_image_info - information specific to a FPGA image
>> -- 
>> 2.7.4
>>
> 
> Thanks,
> Moritz
> 
Regards,
Richard
