Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363D42B44E2
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Nov 2020 14:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgKPNlO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Nov 2020 08:41:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:25578 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgKPNlO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 08:41:14 -0500
IronPort-SDR: rZvpLIJpOasLY/TU7eAth9BKoi6wWHjUDc0+oIQedtkCh0qs6bsblq/9i4bpWgiYHv6sGERQbi
 z/TZ0WfG3xKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="150014076"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="150014076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 05:41:12 -0800
IronPort-SDR: swU2rUbezx+UIdXuRC9aauE+YsaYeddYl8bmNS5VJY5BJml+zloOZ7N8cO1Xd2Av/pz18eVS8G
 ZulkFewp9iMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="531849280"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2020 05:41:12 -0800
Subject: Re: [PATCHv1 0/4] Extend FPGA manager and region drivers for
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <20201116024147.GA8715@yilunxu-OptiPlex-7050>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <051c9fce-339f-de5e-1fb8-311b36e80c79@linux.intel.com>
Date:   Mon, 16 Nov 2020 08:02:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116024147.GA8715@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Yilun,

On 11/15/20 8:41 PM, Xu Yilun wrote:
> On Thu, Nov 12, 2020 at 12:06:39PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> The customer wants to verify that a FPGA bitstream can be started properly
>> before saving the bitstream to the QSPI flash memory.
>>
>> The customer sends the bitstream via FPGA framework and overlay, the
>> firmware will authenticate the bitstream but not program the bitstream to
>> device. If the authentication passes, the bitstream will be programmed into
>> QSPI flash and will be expected to boot without issues.
> 
> So when we have successfully reprogramed region with the
> FPGA_MGR_BITSTREM_AUTHENTICATION flag, the bitstream in QSPI flash is
> updated but not activated, we need an FPGA reboot to activate it, is it?
> 

Correct. If the authentication passes, the bitstream will be programmed 
into QSPI flash and will be expected to boot without issues.

> Thanks,
> Yilun
> 
>>
>> Extend FPGA manager and region drivers to support the bitstream
>> authentication feature.
>>
>> Richard Gong (4):
>>    fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
>>    fpga: of-fpga-region: add authenticate-fpga-config property
>>    dt-bindings: fpga: add authenticate-fpga-config property
>>    fpga: stratix10-soc: entend driver for bitstream authentication
>>
>>   Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>>   drivers/fpga/of-fpga-region.c                          | 3 +++
>>   drivers/fpga/stratix10-soc.c                           | 5 ++++-
>>   include/linux/fpga/fpga-mgr.h                          | 3 +++
>>   4 files changed, 11 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.7.4
