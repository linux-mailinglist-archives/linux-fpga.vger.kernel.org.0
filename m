Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B32FF571
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jan 2021 21:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbhAUUHd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jan 2021 15:07:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:17199 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbhAUUH3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 21 Jan 2021 15:07:29 -0500
IronPort-SDR: bEsIrpupcDZNP9XR7lja7t5az5WqTT2fegzWMjcUUpzkHkNoE4KyR+ifBfZHHHnpjwYDXe739b
 YWELRjaNFj1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="166432312"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="166432312"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:06:48 -0800
IronPort-SDR: uhzGFNIdTEucyivVagc5YmvdPO2Dl8rG7kXC1xcJEMkAE7QOQ//tt2LpdXfBzKe7NA+2pRly5+
 09v3Ie7csGMA==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="467605489"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.217.24])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:06:46 -0800
Subject: Re: [PATCH v7 0/6] Intel MAX10 BMC Secure Update Driver
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210105230855.15019-1-russell.h.weight@intel.com>
 <b13a487f-7437-0278-6a9e-f10a5273065b@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <7cd0fc34-6e6f-4646-a7a9-7c4fb94bc45b@intel.com>
Date:   Thu, 21 Jan 2021 12:06:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b13a487f-7437-0278-6a9e-f10a5273065b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/19/21 12:49 PM, Tom Rix wrote:
> On 1/5/21 3:08 PM, Russ Weight wrote:
>
> ...
>
>>  .../testing/sysfs-driver-intel-m10-bmc-secure |  61 ++
>>  MAINTAINERS                                   |   2 +
>>  drivers/fpga/Kconfig                          |  11 +
>>  drivers/fpga/Makefile                         |   3 +
>>  drivers/fpga/intel-m10-bmc-secure.c           | 543 ++++++++++++++++++
>>  include/linux/mfd/intel-m10-bmc.h             |  85 +++
> I am having trouble pulling this into my testing branch where i am tracking some other changes to intel-m10-bmc.h
>
> https://lore.kernel.org/lkml/20210114231648.199685-1-russell.h.weight@intel.com/
>
> https://lore.kernel.org/lkml/1609999628-12748-3-git-send-email-yilun.xu@intel.com/
>
> so I am wondering if it makes sense to split the intel-m10-bmc.h change out of this patchset and sent as a single patch to mfd subsystem ?  The change is a bunch of #defines that don't do anything on their own, but will conflict with other similar additions to the h file.
If I rebase my working branch onto the latest linux-next, I don't see any issues. But if I apply the patches to the latest linux-next (git am), then I do. Clearly I need to fix up this patch and resend. If there are no objections, I'll split this patch out as an individual patch for the next submission.

- Russ
>
> Tom
>
>>  6 files changed, 705 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>>

