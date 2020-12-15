Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF582DA736
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Dec 2020 05:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgLOEpG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 23:45:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgLOEpF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 23:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608007419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfuNulEUyZ4D9ITyUZwY93F2tD2DkQZvOHANb0nT6DU=;
        b=gQ7bJuToe0+RX2fsdWevl0wQ1wuihKA3TAV53wXZRrq4WvG6CZ08OTuBj6utKBOyjIcKRH
        VGzPJeGGzVf5cfds/l0YKqG7NJPfUCrcLt2KGWMTRxVik2mZJ+yTkJDyun0Bi650h+5IXD
        8sZfBVHKjdyUWhQHFIKn0Mo02pIEIo8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-CrAmu0DzNDqQ-1pPXRvEwQ-1; Mon, 14 Dec 2020 23:43:34 -0500
X-MC-Unique: CrAmu0DzNDqQ-1pPXRvEwQ-1
Received: by mail-qk1-f200.google.com with SMTP id u67so14268684qkd.6
        for <linux-fpga@vger.kernel.org>; Mon, 14 Dec 2020 20:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WfuNulEUyZ4D9ITyUZwY93F2tD2DkQZvOHANb0nT6DU=;
        b=aSbKjeTFmceRAtF9AwgCSRvoNeaNL5MAIUBCypj2XfmA6OsHzMBAI1tlM0WKxoICBS
         ZADYt5DzmC1KSef/NEpCFTUW+Ki+tiRG2rCetI4+DNN89fbL3Iz7ADaKVeckyQfsaGDi
         GW3Z4l67juNmEM7Age8PHqCxOKpzbVVajbaw2G8prgceGrMlHuFvaT0UpL8eHy1QWd4a
         NUKjaGp45StiiH2wJh2mtuLgDIvFrJn8QhnqckcWtEdKVj7Z/beqbvXs6Xek1kK5ygK+
         RsKfEF814VtSWw7OWYWIXdYFmMeIKREzWJacGP2hRn9K/O6gndb1tAVlrFikXfgG8XBj
         SejA==
X-Gm-Message-State: AOAM530jMqzdhoP/Oj7PYbTO3InLa7cPcETzMOMdMsvFlC6x02tybiJN
        JQsc1tanuBj9aaoUjlg6zgQYfNt8Uf8OkYKMpOLz4GRqUehJOjp1Dx0s822/eukgfTpgdSGSoNw
        Jya2vLN1CHwS7sEN1oIk5Ew==
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr33873533qtp.345.1608007414211;
        Mon, 14 Dec 2020 20:43:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyw2Iqn6wYcAolL+BgzRwuOsAKOZ0vpMhN/4n3mV6+6pdjBPUafj7e7ZWksvdH3bY7lag+CjQ==
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr33873521qtp.345.1608007413979;
        Mon, 14 Dec 2020 20:43:33 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a1sm9973010qkn.104.2020.12.14.20.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 20:43:33 -0800 (PST)
Subject: Re: [PATCH v2 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
 <1607916981-14782-3-git-send-email-yilun.xu@intel.com>
 <4bbaa5ad-b0eb-8ea6-9dc6-c08060450e36@redhat.com>
 <20201215022206.GC14854@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <97d06583-ca99-67ae-55e1-ff714b47f8cb@redhat.com>
Date:   Mon, 14 Dec 2020 20:43:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201215022206.GC14854@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/14/20 6:22 PM, Xu Yilun wrote:
> On Mon, Dec 14, 2020 at 02:14:56PM -0800, Tom Rix wrote:
>> On 12/13/20 7:36 PM, Xu Yilun wrote:
>>> This patch adds description for UIO support for dfl devices on DFL
>>> bus.
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> ---
>>> v2: no doc in v1, add it for v2.
>>> ---
>>
>>> +components. They could instantiate a new private feature in the DFL, and then
>>> +get a DFL device in their system. In some cases users may need a userspace
>>> +driver for the DFL device:
>>> +
>>> +* Users may need to run some diagnostic test for their hardwares.
>> * Users may prototype the kernel driver in user space.
> Could we just add the line rather than replacing the previous line? I think this
> comment is describing a different usecase.

Yes, this is what i ment, please use your original.

I am offering another usecase, one I will use.

Add mine as well, if you want.

>
>>> +* Some hardware is designed for specific purposes and does not fit into one of
>>> +  the standard kernel subsystems.
>>> +
>>> +This requires the direct access to the MMIO space and interrupt handling in
>>> +userspace. We implemented a dfl-uio-pdev module which exposes the UIO device
>> The dfl-uio-pdev module exposes
> Will change it.
>
>>> +interfaces. It adds the uio_pdrv_genirq platform device with the resources of
>>> +the DFL device, and let the generic UIO platform device driver provide UIO
>> the DLF device, and lets
> Will change it.
>
>>> +support to userspace.
>> Use FPGA_DFL_UIO_PDEV to enable this feature.
> I didn't get your idea for this.

I wanted the user to know which kconfig controls this feature.

Leave it out if you don't think it fits.

>
>>> +
>>> +The DFL UIO driver has a special matching algorithem. It will match any DFL
>>> +device which could not be handled by other DFL drivers. In this way, it will
>>> +not impact the functionality of the features which are already supported by the
>>> +system.
>> (not sure if this section is needed)
> I think we may keep it.

Ok.

Tom

>
> Thanks,
> Yilun
>

