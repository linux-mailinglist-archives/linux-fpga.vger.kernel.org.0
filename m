Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589183865D1
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 22:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhEQULC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 16:11:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:36552 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234946AbhEQULA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 16:11:00 -0400
IronPort-SDR: arf9OR28gsSqNvIX6rOg8KP2giTAb72p4drjRF1uQhqFx+kMZC5oSTqU9lfZlYlnNb0nRAcHMl
 WuJbkD6oJRog==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221599383"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="221599383"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 13:09:40 -0700
IronPort-SDR: VkxUbDJkBtCV9ANF9w4C8IGPqT6BYRcyQH53+mEcZavvGcyffSsIwfkv++WBmvJRTCBTmz10Es
 tH0lfr9qOChQ==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="543826337"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.243.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 13:09:40 -0700
Subject: Re: [PATCH 08/12] fpga: m10bmc-sec: create max10 bmc secure update
 driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Tom Rix <trix@redhat.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-9-mdf@kernel.org> <YKH/fwAOVW0gLQvQ@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <477bb3d9-80c7-04ce-11c6-af9c046edcf1@intel.com>
Date:   Mon, 17 May 2021 13:09:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YKH/fwAOVW0gLQvQ@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/16/21 10:30 PM, Greg KH wrote:
> On Sun, May 16, 2021 at 07:31:56PM -0700, Moritz Fischer wrote:
>> From: Russ Weight <russell.h.weight@intel.com>
>>
>> Create a platform driver that can be invoked as a sub
>> driver for the Intel MAX10 BMC in order to support
>> secure updates. This sub-driver will invoke an
>> instance of the FPGA Security Manager class driver
>> in order to expose sysfs interfaces for managing and
>> monitoring secure updates to FPGA and BMC images.
> No, please NEVER create a platform device for something that is not
> actually a platform device.  That's a huge abuse of the platform device
> code.
>
> Please use the proper api for this if you need it, hint, it's NOT the
> platform device code.  Your Intel reviewer should have told you what
> it is when they saw a changelog comment like this....

I was following the design of the n3000bmc-hwmon driver, which was recently
accepted upstream.

The MAX10 BMC driver lists sub-devices here, including my device
(n3000bmc-secure) and the n3000bmc-hwmon device:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/intel-m10-bmc.c#n25

The HWMON sub-driver is implemented as a platform driver here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/intel-m10-bmc-hwmon.c

Is the HWMON driver implemented incorrectly? Or is there something fundamentally
different in what I am trying to do? Can you point me in the right direction? What
type of device should this be?

Thanks,

- Russ

>
> greg k-h

