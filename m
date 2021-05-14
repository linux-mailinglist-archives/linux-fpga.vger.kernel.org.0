Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28E5380E3D
	for <lists+linux-fpga@lfdr.de>; Fri, 14 May 2021 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhENQfI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 May 2021 12:35:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:7874 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhENQfI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 May 2021 12:35:08 -0400
IronPort-SDR: JVzPUyDOhSX7vH1tD1IW0qnDLuMIvIVzExgdqe/CUrjCSeudvgC2RzKFCYksjAr1r1x0EOiBar
 +aZT6I3OUWig==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="187324398"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="187324398"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 09:33:55 -0700
IronPort-SDR: CQAbUa1TKH+DXf1TFgGRrr1TBXNaOF2bcDqjTFh1VIuipZ/uMdQcytBz7C2GXclQwACdGdQGSa
 NuYr745ONe0A==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="393682662"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.226.203])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 09:33:54 -0700
Subject: Re: [PATCH v12 0/7] FPGA Security Manager Class Driver
To:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210503213546.316439-1-russell.h.weight@intel.com>
 <6f3ce0db-883e-2c5b-e671-9ccc363ee532@redhat.com>
 <YJlvYNXUcwrBFGey@epycbox.lan>
 <91d29fc4-ac04-270a-f73a-e1dd3ba2965f@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <739f7fec-74a9-ca4e-ba9b-920bba2e6187@intel.com>
Date:   Fri, 14 May 2021 09:33:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <91d29fc4-ac04-270a-f73a-e1dd3ba2965f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Moritz,

On 5/10/21 11:52 AM, Tom Rix wrote:
>
> On 5/10/21 10:37 AM, Moritz Fischer wrote:
>> On Mon, May 10, 2021 at 07:12:57AM -0700, Tom Rix wrote:
>>> On 5/3/21 2:35 PM, Russ Weight wrote:
>>>> The FPGA Security Manager class driver provides a common
>>>> API for user-space tools to manage updates for secure FPGA
>>>> devices. Device drivers that instantiate the FPGA Security
>>>> Manager class driver will interact with a HW secure update
>>>> engine in order to transfer new FPGA and BMC images to FLASH so
>>>> that they will be automatically loaded when the FPGA card reboots.
>>> Russ,
>>>
>>> These have my Reviewed-by, but since it has been a while, I am looking these
>>> over again.
>>>
>>> If you do not hear anything from me in the next couple of days, please
>>> assume everything is fine.
>>>
>>> Tom
>>>
>> I'll do one more one-over, if it looks good will apply end of the week,

I've been out of town for the Monday through Thursday of this week. Should I
address the few comments you had and resubmit before you take these? Or were
you thinking of making the changes yourself?

I'll submit an updated patch set before the end of the day today unless I
hear otherwise...

Thanks,
- Russ

>
> FWIW, my pass was fine.
>
> Thanks,
>
> Tom
>
>>
>> - Moritz
>>
>

