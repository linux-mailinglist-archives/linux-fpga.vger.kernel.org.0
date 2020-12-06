Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6132D05F9
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Dec 2020 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgLFQcw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Dec 2020 11:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbgLFQcw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Dec 2020 11:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607272285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMF+CoVSS643Fc17KXhh3rGOJ/yHoZk4DoSGgm33ivA=;
        b=bxhG7CFMs5KdaS6D9qhnwD5Zv8nlND6o3W9XDMqgnoVyfkkPMJY7qXH2/MO9551nhdLetn
        z+LFBx3p8PXnFhhQN8TYT39//Ejb0yRzSkTXJSxLKkpqSNv0kPrEjNypsPHqUrNTXR8KiJ
        mBRi9LToYztnxskIaOc87EW+/52IKTo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-iTuJhceiMwOMZv1zaqzrUQ-1; Sun, 06 Dec 2020 11:31:22 -0500
X-MC-Unique: iTuJhceiMwOMZv1zaqzrUQ-1
Received: by mail-qt1-f199.google.com with SMTP id f11so9056249qth.23
        for <linux-fpga@vger.kernel.org>; Sun, 06 Dec 2020 08:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CMF+CoVSS643Fc17KXhh3rGOJ/yHoZk4DoSGgm33ivA=;
        b=WbnqkmGsX07W759zcDVFCgnL9TO4E4MwwyCKLIq6xIypz3Dppy+pa1i+nbopK2puvl
         8KbjgEJFoE8n1ce+ne8gTgonK7e+lDS7Pz/LM1aYQRU5jDw/Cg8+4+1hfXjcOAQTeuUk
         iCnHSGSy5QN4vIMy1yPTQLnT/fmFQ6EYYW3OyJbi/MDEGZ6Ij2V4djIj5sugTgEXKqJS
         tG+eMIhd00YinprwMu50zhlUHuXr900we1kq349kzeUsK+uW7j9/L5YrhVWkuCO1UdUe
         DO/t3ps4ueddWo8sghqP7YfoaQraR09PGky0EIlk1Ht1bRn2QzCF4TXlfC0p0AOpRiNc
         Gfjw==
X-Gm-Message-State: AOAM532adBm7ia81qyTILBddmmK3gQWOQ9RzNLLCarhRrdsS2Atyz0mX
        RnjH091wDSFAyTyTh5dUxuCmxULP+SP+MOxmNYprEOsfYRv24QlyXxzU4SNNtMU5CMG3j8k0qkJ
        /bqwW76jzIYX9zeH9ew1xVA==
X-Received: by 2002:ac8:bc7:: with SMTP id p7mr19756345qti.91.1607272282315;
        Sun, 06 Dec 2020 08:31:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRjzb3ETLrTBxkdDegvZLQf2Fn3hwR6fns803HxOqkK73W88fwCB9NZ01f3lD4Rew17E3XSQ==
X-Received: by 2002:ac8:bc7:: with SMTP id p7mr19756331qti.91.1607272282050;
        Sun, 06 Dec 2020 08:31:22 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l10sm10618585qti.37.2020.12.06.08.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 08:31:21 -0800 (PST)
Subject: Re: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
To:     Sonal Santan <sonal.santan@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc:     Sonal Santan <sonals@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, lizhih@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org
References: <20201129000040.24777-1-sonals@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <457f9fad-f108-26de-3cdb-b367a4782ef2@redhat.com>
Date:   Sun, 6 Dec 2020 08:31:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 11/28/20 4:00 PM, Sonal Santan wrote:
> Hello,
>
> This patch series adds management physical function driver for Xilinx Alveo PCIe
> accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> This driver is part of Xilinx Runtime (XRT) open source stack.

A few general things.

Use scripts/get_maintainer.pl to find who a patch should go to, i should have been on the cc line.

Each patch should at a minimum pass scripts/checkpatch.pl, none do.

Looking broadly at the files, there are competing names xrt or alveo.

It seems like xrt is the dfl equivalent, so maybe

drivers/fpga/alveo should be drivers/fpga/xrt

There are a lot of files with unnecessary prefixes

ex/

fpga/alveo/include/xrt-ucs.h could just be fpga/alveo/include/ucs.h

individual subdev's may not belong in the fpga subsystem.

I think it would be better to submit these one at a time as is done for dfl.

So this will not block getting the basics done, in the next revision, can you leave the subdev's out ?

 

Because of the checkpatch.pl failures, I will wait for the next revision.

Tom


