Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED2B383D91
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhEQTjI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 15:39:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:42548 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhEQTjI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 15:39:08 -0400
IronPort-SDR: QHn/egflCEZbuw3XKfC1blHtfzTaLXW5EbbzB6r8MXxTl2Qzsuauawkvk6d29L7H8hRVMx5N4p
 a0AIQjMkFKUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="198601147"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="198601147"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 12:37:51 -0700
IronPort-SDR: BVPJNKFsktd7PcDl+s9UprigQ8xws9oGyIBl87P1L6ONweQkK9zfNiieUOKEIGfUe6jAK9b20v
 uK3kJrQz7KcA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="543817544"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.243.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 12:37:51 -0700
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
To:     Greg KH <gregkh@linuxfoundation.org>, Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org> <YKH/6xQ7bEwJzEsM@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
Date:   Mon, 17 May 2021 12:37:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YKH/6xQ7bEwJzEsM@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/16/21 10:32 PM, Greg KH wrote:
> On Sun, May 16, 2021 at 07:31:50PM -0700, Moritz Fischer wrote:
>> From: Russ Weight <russell.h.weight@intel.com>
>>
>> Extend the FPGA Security Manager class driver to
>> include an update/filename sysfs node that can be used
>> to initiate a secure update.  The filename of a secure
>> update file (BMC image, FPGA image, Root Entry Hash image,
>> or Code Signing Key cancellation image) can be written to
>> this sysfs entry to cause a secure update to occur.
> Why is userspace responsible for triggering this?  Passing a "filename"
> into the kernel and having it do something with it is ripe for major
> problems, please do not.
>
I am using the "request_firmware" framework, which accepts a filename
and finds the firmware file under /lib/firmware.

Is this not an acceptable use for request_firmware?

- Russ
