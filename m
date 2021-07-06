Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1B3BD8A9
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jul 2021 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhGFOpu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jul 2021 10:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhGFOpj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jul 2021 10:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIGlWplN3h4+H7k0zEf33Wa5rvWTcEsOsBYR4qfAjpI=;
        b=Pe+of7FlJbsK2KCgzqKjj5XxtJjjJz3rMPQG4d0cZTtAoCn/ngqZJ5KOvZ1HHvnS19B2Zo
        rXKeCHWQ/hSbGWNlnnQfjyG15d4GGrx4Nd2HzhM3UpC8kdC48+1/kwMxmCSVpXCk0BbFsm
        KlgmybBAVK7maZNhnbykrx1Ga5/XQ6I=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-48QIyownOXCQHwU3mx1KNA-1; Tue, 06 Jul 2021 09:52:12 -0400
X-MC-Unique: 48QIyownOXCQHwU3mx1KNA-1
Received: by mail-oi1-f199.google.com with SMTP id l4-20020aca57040000b0290240a9d123c6so4624446oib.0
        for <linux-fpga@vger.kernel.org>; Tue, 06 Jul 2021 06:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hIGlWplN3h4+H7k0zEf33Wa5rvWTcEsOsBYR4qfAjpI=;
        b=PRuHxtgGbzYMsyTg6m5tVS4DZlqn+u2vXKVnqYY7U3f3jJn2Ae628EhVL9NLfCuH5J
         /Sm+wQ5HkSo2AOOKarmPuqIqvW4thYNty5G6AeBtENaAecT65gs+35XovB+y6z8fX/n7
         YlyE+9WIx+hBcM98KE6n++zwEm6Q11vIRp4rUs6Shn1OBJ9wWrPLFnJ5hk8AypLH5fTt
         eNye25x/m8zn9T/Bm5RvomoXTIzKRuenLtgL1iiqzddIcTJPFDsB35Ac/UHWtfL5NLdu
         ETU8LNE0O9jU9OVDkNFepS4pcbzWydiCu1R4zHNl/mHAj+r5M4IfVak3BJRcvNl3xcJA
         HdWg==
X-Gm-Message-State: AOAM532cU0dtHni4OjN6I4x3y+D2PDHVpvFvGdJQRoyUbS0w7i+EyxuO
        8bvRuhRRvNQynwS5ful6/jokC/O288qhnglTU+1CX5XljT3N/Jcmp64+1wopE4tO275dKd+tKPC
        Gh+dBo0bwP63vgFQFnW4lA/pdqMV3Ci1rprWqfFeP/j8OyNjUG9mJXbSHhN4t82DQFz74
X-Received: by 2002:a9d:8d3:: with SMTP id 77mr903124otf.6.1625579531296;
        Tue, 06 Jul 2021 06:52:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsEe7Coa/1uFo0NgCw7WGdJ4W6Zi4fbDPurzCeh25mF9UZO/rfDPRn55ROq89hhBabddzPfQ==
X-Received: by 2002:a9d:8d3:: with SMTP id 77mr903109otf.6.1625579531076;
        Tue, 06 Jul 2021 06:52:11 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w16sm1202113oik.15.2021.07.06.06.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:52:10 -0700 (PDT)
Subject: Re: [PATCH] bus: Make remove callback return void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4c7210e4-76e4-07fe-a40c-a58e331d0a6e@redhat.com>
Date:   Tue, 6 Jul 2021 06:52:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/6/21 2:50 AM, Uwe Kleine-König wrote:
> The driver core ignores the return value of this callback because there
> is only little it can do when a device disappears.
>
> This is the final bit of a long lasting cleanup quest where several
> buses were converted to also return void from their remove callback.
> Additionally some resource leaks were fixed that were caused by drivers
> returning an error code in the expectation that the driver won't go
> away.
>
> With struct bus_type::remove returning void it's prevented that newly
> implemented buses return an ignored error code and so don't anticipate
> wrong expectations for driver authors.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> this patch depends on "PCI: endpoint: Make struct pci_epf_driver::remove
> return void" that is not yet applied, see
> https://lore.kernel.org/r/20210223090757.57604-1-u.kleine-koenig@pengutronix.de.
>
> I tested it using allmodconfig on amd64 and arm, but I wouldn't be
> surprised if I still missed to convert a driver. So it would be great to
> get this into next early after the merge window closes.
>
> I send this mail to all people that get_maintainer.pl emits for this
> patch. I wonder how many recipents will refuse this mail because of the
> long Cc: list :-)
>
> Best regards
> Uwe

>   drivers/fpga/dfl.c                        | 4 +---
Reviewed-by: Tom Rix <trix@redhat.com>

