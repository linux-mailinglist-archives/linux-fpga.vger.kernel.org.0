Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0D49D8B6
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Jan 2022 03:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiA0C4T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Jan 2022 21:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiA0C4Q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 26 Jan 2022 21:56:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D799C06161C
        for <linux-fpga@vger.kernel.org>; Wed, 26 Jan 2022 18:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9C7DB82103
        for <linux-fpga@vger.kernel.org>; Thu, 27 Jan 2022 02:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204FBC340E7;
        Thu, 27 Jan 2022 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643252173;
        bh=6K5LRw/6eBLzwguKuZ4Ic8YCdbuKrVGa7fgHQ0790Nw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r1uxFpyMmqpV2pp9ijFGYaa+LyGW2MXQHdp8HWP8cnYPLkg2aFqIhp+SAlN69HEgM
         yrjaQWGslLNAUKui5jXHAORZfQ2Eae/MQ/IhPqEPen6aiub8Mbacndnzyw5fGP02Iz
         zVJqH6Y926PcbxXt/etrxhCqH7SIuMEhT6DCBFxXduAKZjyqc8miWR9RumTF+wI4rK
         99L9eFIFg+pK+kO3PRsEvvBfz4Df4DiFeHDUxzaFh80HzUSjheoAqt4i9p1kViZqBq
         oIIUWWyf5mwCKcKsJpEHa5WY8o7MChQXcGaXe359ui8WBe6Qlf/vPZnqAvas2VJ4Vc
         cTgnFZIg1t13A==
Message-ID: <1f6acc9f-da52-df60-e1fb-53b86419457a@kernel.org>
Date:   Wed, 26 Jan 2022 20:56:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
References: <20220125192853.1956486-1-dinguyen@kernel.org>
 <20220126010723.GA1139334@yilunxu-OptiPlex-7050>
 <5a1b6658-062c-d777-69d3-6a053d087ca6@kernel.org>
 <YfDUGD5+hqOnSNjP@epycbox.lan>
 <20220127003902.GA1144478@yilunxu-OptiPlex-7050>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220127003902.GA1144478@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/26/22 18:39, Xu Yilun wrote:
> On Tue, Jan 25, 2022 at 08:54:48PM -0800, Moritz Fischer wrote:
>> Dinh,
>>
>> On Tue, Jan 25, 2022 at 10:31:06PM -0600, Dinh Nguyen wrote:
>>>
>>>
>>> On 1/25/22 19:07, Xu Yilun wrote:
>>>> On Tue, Jan 25, 2022 at 01:28:53PM -0600, Dinh Nguyen wrote:
>>>>> From: Richard Gong <richard.gong@intel.com>
>>>>>
>>>>> Extend Intel service layer driver to get the firmware version running at
>>>>> FPGA device. Therefore FPGA manager driver, one of Intel service layer
>>>>> driver's client, can decide whether to handle the newly added bitstream
>>>>> authentication function based on the retrieved firmware version.
>>>>>
>>>>> Acked-by: Moritz Fischr <mdf@kernel.org>
>>>>
>>>> This is already acked and no more change, is it? So please just ping in
>>>> the original mail or add the [RESEND PATCH] prefix.
>>>>
>>>> The patch is good to me.
>>>>
>>>> Acked-by: Xu Yilun <yilun.xu@intel.com>
>>>>
>>>
>>> Thanks, I added Moritz Acked-by: is the only change.
>>>
>>> Dinh
>>
>> Did we traditionally take those through FPGA tree, did Greg pick those
>> up?
> 
> This patch was the 3rd one of a patchset. It is acked but the patchset
> is not, so we didn't take the single one in FPGA tree. This is the last
> conversation.
> 
> https://lore.kernel.org/linux-fpga/YGDsl3VlIAnyJDzd@epycbox.lan/
> 

Right, Richard has left Intel. So what I've done is gone back and try to 
re-send patches that have been Acked, like this one, and split out the 
other patches to a smaller series to restart the process.

Dinh
