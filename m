Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230730CE24
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Feb 2021 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhBBVnK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Feb 2021 16:43:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:64619 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234114AbhBBVmq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 2 Feb 2021 16:42:46 -0500
IronPort-SDR: JcAYSx8dS08FD+BlSjmtlAgeGrVnvrEStZ59bxq/TKikXQG/deoC0XLcaZVY9qp8NlOpxKVQ/V
 DwDgWz7pk61A==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181081895"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="181081895"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 13:40:59 -0800
IronPort-SDR: asmWp1QY24TIDG7pef9yM7XBm68sR8mtJyGYqbxJfxtwO2nGiDRsrz4Il07yUK/wCjTvZ41CW2
 VM++/ccXZJ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="370961433"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2021 13:40:58 -0800
Subject: Re: [PATCHv4 5/6] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
References: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
 <1612192919-4069-6-git-send-email-richard.gong@linux.intel.com>
 <YBjUyc2ea51S4Wzp@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <9752d0eb-962a-f308-24a3-aedd4fecf25d@linux.intel.com>
Date:   Tue, 2 Feb 2021 16:01:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBjUyc2ea51S4Wzp@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 2/1/21 10:27 PM, Moritz Fischer wrote:
> On Mon, Feb 01, 2021 at 09:21:58AM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add authenticate-fpga-config property for FPGA bitstream authentication,
>> which makes sure a signed bitstream has valid signatures.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v4: explain authenticate-fpga-config flag further
>> v3: no change
>> v2: put authenticate-fpga-config above partial-fpga-config
>>      update commit messages
>> ---
>>   Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> index e811cf8..e2740b6 100644
>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> @@ -182,6 +182,10 @@ Optional properties:
>>   	This property is optional if the FPGA Manager handles the bridges.
>>           If the fpga-region is  the child of a fpga-bridge, the list should not
>>           contain the parent bridge.
>> +- authenticate-fpga-config : boolean, set if do bitstream authentication only.
>> +	flag authenticate-fpga-config is used to first check the integrity of
>> +	the bitstream. If the authentication is passed, the user can perform
>> +	other operations.
>  From the other commits it looks like it *also* writes to QSPI? If so
> please document that.
> 
> If not, feel free to ignore :)
> 
> Maybe I would highlight two things:
> a) If you add 'authenticate-fpga-config' you are not allowed to add new
>     nodes
> b) If you add 'authenticate-fpga-config' you are not alllowed to add
>     other operations

How about the descriptions below?

- authenticate-fpga-config : boolean, set if do bitstream authentication 
only.
If 'authenticate-fpga-config' is added then adding a new node or another 
operation is not allowed.
Flag authenticate-fpga-config is used to check the integrity of the 
bitstream.
Except for the actual configuration of the device, the authentication 
works in the same way as FPGA configuration. If the authentication 
passes, other operations such as full or partial reconfiguration can be 
performed. When the bitstream into QSPI flash memory at device is 
programmed, it is expected that there will be no issue when starting the 
device.

>>   - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
>>   	otherwise full reconfiguration is done.
>>   - external-fpga-config : boolean, set if the FPGA has already been configured
>> -- 
>> 2.7.4
>>
> Thanks,
> Moritz
> 
Regards,
Richard
