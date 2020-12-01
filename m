Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B082CAD6A
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 21:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgLAUdM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 15:33:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:4314 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgLAUdL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 15:33:11 -0500
IronPort-SDR: Flst2d54Dk6E3m+hBHIP0zpSMkE50KaHJpnj2QWuW7DzestaXsNuarjvx5fUpwuf5gI7YdNl/V
 mhDwI7BwX+9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="172999292"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="172999292"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 12:31:26 -0800
IronPort-SDR: EiOcC6sky8HhCK41YcXxgYjV4u9CVgQIj0nOazVFwOWG5DB73cMWW2cQaOtY+6WZaSUaN28Q4A
 35ZpzHBomEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="537675914"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2020 12:31:25 -0800
Subject: Re: [PATCHv2 1/5] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@intel.com
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
 <X7U+BTkW7ZmsMByV@epycbox.lan>
 <d8b58b40-63c6-115e-8e61-f092e3f050b3@linux.intel.com>
 <X7m6gy/B8DiafyYQ@archbook>
 <771ba4f4-59e1-74b0-ba55-3f65914e2bc7@linux.intel.com>
 <X8XHJimPDaE/lNx0@archbook>
 <e67a2abe-2c97-fe1c-9dc7-100b8a20381b@linux.intel.com>
 <X8aXNKNIPl+piFO+@archbook>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <48b61d87-331a-6dba-212e-8b6748429afe@linux.intel.com>
Date:   Tue, 1 Dec 2020 14:52:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8aXNKNIPl+piFO+@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

On 12/1/20 1:19 PM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Tue, Dec 01, 2020 at 01:30:16PM -0600, Richard Gong wrote:
> 
>>> Can U-Boot determine whether it's the new or old flow? Can you set a
>>> different compatible value in your device-tree, to disambiguate
>>> behaviors?
>>>
>>
>> The boot flow is determined by defconfig during compilation, which means
>> each boot flow will have its own defconfig.
>>
>> SDM firmware loads SPL into OCRAM, then SPL will load the apporiate ATF or
>> U-boot into the DRAM according to the setting of CONFIG_SPL_ATF. If
>> CONFIG_SPL_ATF=y, SPL loads ATF and then jumps to ATF. ATF setups EL3
>> environment and initialize the PSCI services.
>>
>> CONFIG_SPL_ATF is not set for the old boot flow.
> 
> So you know at (U-Boot) build time? Can you just pass a different DT to
> the kernel in that case?
> 

Yes, we have decided the boot flow at build time. Starting from the next 
release, our U-boot will use the ATF boot flow.

Per my limited knowledge in U-boot, I don't think we can follow your 
suggestion. Or it will take a lot of efforts to achieve.

I think that back compatibility is your main concern, correct? the issue 
does exist with the old boot flow and old firmware, whenever the 
customers try to use authentication. Unfortunately we can't update 
U-boot or firmware that has been released.

The authentication feature is supported only at the ATF boot flow, 
updated kernel and firmware. We will have a well-documented document to 
inform our customers that if they want to have authentication feature, 
they need to upgrade the latest U-boot, kernel and firmware.

We always encourage our customers to take the latest U-boot, kernel and 
firmware releases in their developments.

> - Moritz
> 

Regards,
Richard
