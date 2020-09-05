Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A6F25E47D
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 02:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIEAFD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 20:05:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:22235 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgIEAFC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 20:05:02 -0400
IronPort-SDR: 5RCKcsKhxbyLZMRQ4Jtb6oIFHTRLd/ZdOvZpA+jRjySF+P9Noq6zCRaO9MJtSUVKDz53UM5CwA
 EQrJOiP4Gk4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155231561"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="155231561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 17:05:02 -0700
IronPort-SDR: d3Fy19cxtUXmHEpBc37p3tMGtxK0xbReOFGZB7wD2i0BBMUc/jsGwNEOhgzH75qnA9aQYuL7lA
 /7ttd7xMXfgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="302794829"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.251.151.80])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2020 17:05:00 -0700
Subject: Re: [PATCH v1 02/12] fpga: create intel max10 bmc security engine
To:     Randy Dunlap <rdunlap@infradead.org>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-3-russell.h.weight@intel.com>
 <d0b74ad9-5bdb-4085-83f2-1008471eba41@infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <42b5bf30-d31e-0a80-704d-98517c098cfa@intel.com>
Date:   Fri, 4 Sep 2020 17:05:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0b74ad9-5bdb-4085-83f2-1008471eba41@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 5:01 PM, Randy Dunlap wrote:
> On 9/4/20 4:52 PM, Russ Weight wrote:
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 97c0a6cc2ba7..0f0bed68e618 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -244,4 +244,15 @@ config IFPGA_SEC_MGR
>>   	  region and for the BMC. Select this option to enable
>>   	  updates for secure FPGA devices.
>>   
>> +config IFPGA_M10_BMC_SECURE
>> +        tristate "Intel MAX10 BMC security engine"
>> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
>> +        help
>> +          Secure update support for the Intel MAX10 board management
>> +	  controller.
> Please consistently use one tab to indent Kconfig keywords (tristate, depends, help)
> and one tab + 2 spaces to indent help text.
> (as in Documentation/process/coding-style.rst)

Thanks for the feedback. I'll fix these.

>> +
>> +	  This is a subdriver of the Intel MAX10 board management controller
>> +	  (BMC) and provides support for secure updates for the BMC image,
>> +	  the FPGA image, the Root Entry Hashes, etc.
>> +
>>   endif # FPGA
>
> thanks.
