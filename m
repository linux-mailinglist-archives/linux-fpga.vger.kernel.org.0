Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E614F2B452E
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Nov 2020 14:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgKPNxz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Nov 2020 08:53:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:39479 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgKPNxw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 08:53:52 -0500
IronPort-SDR: B/OAyuzbBNHcibXMX97uqH1SaJHmueaMKH8ggmLXfwwuCEbzYiaY6mwoyuF9KZA5lrdQmX7Bck
 f2qAJuur3+/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="169962075"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="169962075"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 05:53:51 -0800
IronPort-SDR: 5El4P6fk4qn62fdct5ZkAD9m3mIBukH55ffkyku/l6W7g0s0kZqoHjkui45EcQj23D1P63zQsy
 SlGDh7n75gaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="531852296"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2020 05:53:51 -0800
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <20201115192106.GB283592@epycbox.lan>
 <20201116024758.GA6810@yilunxu-OptiPlex-7050>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <d83b37c2-2baa-b366-8ca4-bb2924bcd4f9@linux.intel.com>
Date:   Mon, 16 Nov 2020 08:14:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116024758.GA6810@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Yilun,

On 11/15/20 8:47 PM, Xu Yilun wrote:
> On Sun, Nov 15, 2020 at 11:21:06AM -0800, Moritz Fischer wrote:
>> Hi Richard,
>>
>> On Thu, Nov 12, 2020 at 12:06:42PM -0600, richard.gong@linux.intel.com wrote:
>>> From: Richard Gong <richard.gong@intel.com>
>>>
>>> Add authenticate-fpga-config property for FPGA bitstream authentication.
>>>
>>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>>> ---
>>>   Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>> index e811cf8..7a512bc 100644
>>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>> @@ -187,6 +187,7 @@ Optional properties:
>>>   - external-fpga-config : boolean, set if the FPGA has already been configured
>>>   	prior to OS boot up.
>>>   - encrypted-fpga-config : boolean, set if the bitstream is encrypted
>>> +- authenticate-fpga-config : boolean, set if do bitstream authentication
>> It is unclear to me from the description whether this entails
>> authentication + reconfiguration or just authentication.
>>
>> If the latter is the case this should probably be described as such.
> 
> If it is just authentication, do we still need to disable bridges in
> fpga_region_program_fpga?
> 

Yes.

Except for the actual configuration of the device, the authentication 
feature is the same as FPGA configuration.

Regards,
Richard

> I'm wondering if the FPGA functionalities could still be working when
> the authenticating is ongoing, or when the authenticating is failed.
> 



> Thanks,
> Yilun
> 
>>
>>>   - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>>>   	bridges to successfully become enabled after the region has been
>>>   	programmed.
>>> -- 
>>> 2.7.4
>>>
>>
>> Thanks
