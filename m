Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF5303EE8
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 14:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391958AbhAZNjl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 08:39:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:52653 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392690AbhAZNje (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 08:39:34 -0500
IronPort-SDR: cNJdLxyKjbdrnq5AEIne49BoqK1RhzeTzYZvckey0vJI3ADXjrQ3OSCaCwN7Fq3rkNwhZ29IdG
 Vz/u8AosiP3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="176390416"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="176390416"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 05:37:37 -0800
IronPort-SDR: RIU2LCL36R7kbA6UP0kB3ccuaFbVz2wYJXgoEoDF7X3QWQemGpOQHFM6pAslaobQyuVhnbhy1i
 q83oskIH/s6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="356725435"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2021 05:37:36 -0800
Subject: Re: [PATCHv3 5/6] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-6-git-send-email-richard.gong@linux.intel.com>
 <YA+jESIpV/cRTECe@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <ee3546a4-91e4-12d2-bd86-acf5e2683a82@linux.intel.com>
Date:   Tue, 26 Jan 2021 07:58:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA+jESIpV/cRTECe@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/25/21 11:05 PM, Moritz Fischer wrote:
> On Mon, Jan 25, 2021 at 02:56:27PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add authenticate-fpga-config property for FPGA bitstream authentication,
>> which makes sure a signed bitstream has valid signatures.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v3: no change
>> v2: put authenticate-fpga-config above partial-fpga-config
>>      update commit messages
>> ---
>>   Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> index e811cf8..d0d3234 100644
>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> @@ -182,6 +182,7 @@ Optional properties:
>>   	This property is optional if the FPGA Manager handles the bridges.
>>           If the fpga-region is  the child of a fpga-bridge, the list should not
>>           contain the parent bridge.
>> +- authenticate-fpga-config : boolean, set if do bitstream authentication only.
> I don't understand. Can I do authenticate-fpga-config AND
> partial-fpga-config?

Yes, but not simultaneously.

Flag authenticate-fpga-config is used to first check the integrity of 
the bitstream. If the authentication passes, the user can perform a full 
or partial configuration to actually configure the bistream to device.

>>   - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
>>   	otherwise full reconfiguration is done.
>>   - external-fpga-config : boolean, set if the FPGA has already been configured
>> -- 
>> 2.7.4
>>
> Please clarify,
> 
> Moritz
> 
Regards,
Richard
