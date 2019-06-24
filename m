Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B545102B
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Jun 2019 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfFXPTr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 Jun 2019 11:19:47 -0400
Received: from foss.arm.com ([217.140.110.172]:53276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbfFXPTq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 Jun 2019 11:19:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709902B;
        Mon, 24 Jun 2019 08:19:45 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD0FB3F71E;
        Mon, 24 Jun 2019 08:19:43 -0700 (PDT)
Subject: Re: [PATCH v2 13/28] drivers: Introduce
 class_find_device_by_of_node() helper
To:     peda@axentia.se, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, atull@kernel.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org, broonie@kernel.org,
        f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        andrew@lunn.ch, lgirdwood@gmail.com, jslaby@suse.com
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-14-git-send-email-suzuki.poulose@arm.com>
 <325e46fd-a480-78ed-81fd-55e993fbc06f@axentia.se>
 <5cf1a8e2-bb1e-b6bc-32fe-93db0a6b5efd@arm.com>
 <528dcb2e-3611-00a7-abb2-cc18001f4f8f@axentia.se>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8c8f447d-71a9-0420-590d-94710131c69d@arm.com>
Date:   Mon, 24 Jun 2019 16:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <528dcb2e-3611-00a7-abb2-cc18001f4f8f@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 24/06/2019 15:07, Peter Rosin wrote:
> On 2019-06-24 10:34, Suzuki K Poulose wrote:
>> Hi Peter,
>>
>> On 22/06/2019 06:25, Peter Rosin wrote:
>>> On 2019-06-14 19:54, Suzuki K Poulose wrote:
>>>> Add a wrapper to class_find_device() to search for a device
>>>> by the of_node pointer, reusing the generic match function.
>>>> Also convert the existing users to make use of the new helper.
>>>>
>>>> Cc: Alan Tull <atull@kernel.org>
>>>> Cc: Moritz Fischer <mdf@kernel.org>
>>>> Cc: linux-fpga@vger.kernel.org
>>>> Cc: Peter Rosin <peda@axentia.se>
>>>> Cc: Mark Brown <broonie@kernel.org>
>>>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>>> Cc: Jiri Slaby <jslaby@suse.com>
>>>> Acked-by: Mark Brown <broonie@kernel.org>
>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>> Reviewed-by: Peter Rosin <peda@axentia.se>
>>>
>>> Whoooa! I reviewed only the drivers/mux/core.c changes when this was done
>>> in a series of much smaller patches. This tag makes it seem as if I have
>>> reviewed the whole thing, which I had not done when you added this tag out
>>> of the blue.
>>
>> Apologies for the surprise. The patch was simply squashed with the change that
>> introduced the "helper" to better aid the reviewers, based on suggestions on the
>> list. I kept your tags, only because there were no changes, but some additional
>> context on the core driver.
> 
> You could e.g. have written:
> 
> 	...
> 	[For the drivers/mux/core.c part]
> 	Reviewed-by: Peter Rosin <peda@axentia.se>
> 	...

Ok. This might change again, another level of merging, but no changes to the
hunk for mux. So I can use the above.

Cheers
Suzuki
