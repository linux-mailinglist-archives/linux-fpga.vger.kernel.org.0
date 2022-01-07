Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7F487320
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Jan 2022 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiAGGek (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Jan 2022 01:34:40 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:55270 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiAGGek (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Jan 2022 01:34:40 -0500
Received: from [192.168.1.18] ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5iphnH3Y7w2Xx5ipinF57P; Fri, 07 Jan 2022 07:34:39 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 07 Jan 2022 07:34:39 +0100
X-ME-IP: 90.11.185.88
Message-ID: <5ed8c8d1-aa61-b2ba-62ff-6714a83c96ba@wanadoo.fr>
Date:   Fri, 7 Jan 2022 07:34:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 03/16] fpga: dfl: pci: Remove usage of the deprecated
 "pci-dma-compat.h" API
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, hao.wu@intel.com,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <4a0a48fb682d13e6861f604d3cad3424672bee1f.1641500561.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a0MfHbB8ZFuTJpbVwPLZ-9QY-MWRFGukW1S4rbBBuDRzw@mail.gmail.com>
 <CAK8P3a01EyEzJKyk2upmvXW-VEb6XRGZgeBwEzH=jJYYL3saGg@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAK8P3a01EyEzJKyk2upmvXW-VEb6XRGZgeBwEzH=jJYYL3saGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Le 07/01/2022 à 01:58, Arnd Bergmann a écrit :
> On Thu, Jan 6, 2022 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
> 
>>> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
>>> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
>>> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
>>
>> This is a correct conversion of the driver, but I'd prefer to keep this separate
>> from the pci-dma-compat series.
> 
> Nevermind, I just misread the patch, and it is required after all to get
> rid of pci_set_dma_mask()
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 

Hi,

I also have another WIP which removes these DMA(32) fallbacks.
It will be clean-up later-on.

CJ

