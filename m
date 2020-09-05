Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E8F25E942
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIERRG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 5 Sep 2020 13:17:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbgIERRF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 5 Sep 2020 13:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599326223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGH1OnR/QF8fAlfetLwGLNG+GGcP9kLctGj2h9MJIrs=;
        b=b6Kr2cFgV6Zpq3sqVqc6PGg1/2tIY8FjPbPSmcS9FSsAg6HRKGlwtV+X7wmX9+APCYeN3c
        b1If4skq9M8VTs4oVrVwKUem8rZMeJm1X+xKdhbnA/Y3U/9pbkYG8SXAC6zqiZTkGZ/mYY
        too/cyyuVW2/5rHi9Mo9fzpAf9SWc3E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-71pZP6LlPzmi3F8pGZOYzg-1; Sat, 05 Sep 2020 13:16:59 -0400
X-MC-Unique: 71pZP6LlPzmi3F8pGZOYzg-1
Received: by mail-qt1-f200.google.com with SMTP id r22so6408313qtc.9
        for <linux-fpga@vger.kernel.org>; Sat, 05 Sep 2020 10:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OGH1OnR/QF8fAlfetLwGLNG+GGcP9kLctGj2h9MJIrs=;
        b=MtieBSjeV519OXJNio9+AZUjIcIFLldVJujer7wC/IXp0W6HVgJCOmeVnIdajGYZS0
         J44KPNeFc3JabdusRv3MrPCJjqwP2LoEYXWrYoYlAtNs1/JYts5e7+EZwT9Q9RRZeO5l
         y2n98UvJYu643yONZ9S0OUm/Yu3py2GT64joCKkOJkmvyFdKPl2a5aSG0gnkuAULc8AT
         eY8QxPdkhBHiJOftHywtkyazWeNaYdTyu+Yd7k+ONTasdsdBi6MqrYQClmAJq1xEOdjG
         2uz1m3P5c+89sy/5kyHP1Hcogk1qHag80oYGGKq8cZtO5ZNI44fMXKM+6gqS7Kou1DKX
         /jcQ==
X-Gm-Message-State: AOAM533tf9FV/LNVs7tFpXIW8iie5B6PbWmYieQbHNlk0/AfhDAbFApM
        iTjhfvaxTWC+2fTchLdQNELrplU5ktTsc1mmcV2TCCqOaxXXtJu+Xv84D/wsKFW6FYZ6GpW8cGg
        0UqSWlVxGr3OlcyUXq1WHcw==
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr12686358qkv.68.1599326219189;
        Sat, 05 Sep 2020 10:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGkgNlnjq7sXD89ZZZPWab22phjXYNVylh52vCAoImwt8VZZowarPMOEpWWRdtGCLfo67SLQ==
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr12686338qkv.68.1599326218833;
        Sat, 05 Sep 2020 10:16:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c7sm7024602qkd.92.2020.09.05.10.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 10:16:58 -0700 (PDT)
Subject: Re: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
To:     linux-kernel@vger.kernel.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4d554f31-1267-92cc-f717-00992144c41b@redhat.com>
Date:   Sat, 5 Sep 2020 10:16:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

resending.
sorry for blowing past 80 chars.

On 9/4/20 4:52 PM, Russ Weight wrote:
> These patches depend on the patchset: "add regmap-spi-avmm & Intel
> Max10 BMC chip support" which is currently under review.

https://marc.info/?l=linux-kernel&m=159782274232229&w=2

regmap-spi-avmm is in linux-next.

max10 is not. however applying it does not resolve resolve
git am conflicts with yesterday's linux-next.
I normally build the larger patchsets as a test.

>
>            --------------------------------------------------
>
> This patchset introduces the Intel Security Manager class driver
> for managing secure updates on Intel FPGA Cards. It also provides
> the n3000bmc-secure mfd sub-driver for the MAX10 BMC for the n3000
> Programmable Acceleration Cards (PAC). The n3000bmc-secure driver
> is implemented using the Intel Security Manager class driver.
>
> The Intel Security Manager class driver provides a common API for
> user-space tools to manage updates for Secure FPGA devices. Device
> drivers that instantiate the Intel Security Manager class driver will
> interact with the HW secure update engine in order to transfer
> new FPGA and BMC images to FLASH so that they will be automatically
> loaded when the FPGA card reboots.
>
> The API consists of sysfs nodes and supports the following functions:
>
> (1) Instantiate and monitor a secure update
> (2) Display security information including: Root Entry Hashes (REH),
>     Cancelled Code Signing Keys (CSK), and flash update counts for
>     both BMC and FPGA images.
>
> Secure updates make use of the request_firmware framework, which
> requires that image files are accessible under /lib/firmware. A request
> for a secure update returns immediately, while the update itself
> proceeds in the context of a kernel worker thread. Sysfs files provide
> a means for monitoring the progress of a secure update and for
> retrieving error information in the event of a failure.
>
> The n3000bmc-secure driver instantiates the Intel Security Manager
> class driver and provides the callback functions required to support
> secure updates on Intel n3000 PAC devices.

This is a good description.  Because security manager is a new
interface, there should be a Documentation/fpga/ifpga-sec-mgr.rst
to collect this description.

How will these devices be discovered ? n3000 is a dfl device,
will there be a dfl feature id for it at some point ? 

Can you describe if/how the security manager would live outside
of dfl ?  I am wondering why this shouldn't be dfl-sec-mgr. 

I did not see any version handling.  How would this sw adapt
to a newer or older version of the bmc interface?

Tom

>
> Russ Weight (12):
>   fpga: fpga security manager class driver
>   fpga: create intel max10 bmc security engine
>   fpga: expose max10 flash update counts in sysfs
>   fpga: expose max10 canceled keys in sysfs
>   fpga: enable secure updates
>   fpga: add max10 secure update functions
>   fpga: expose sec-mgr update status
>   fpga: expose sec-mgr update errors
>   fpga: expose sec-mgr update size
>   fpga: enable sec-mgr update cancel
>   fpga: expose hardware error info in sysfs
>   fpga: add max10 get_hw_errinfo callback func
>
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 151 ++++
>  MAINTAINERS                                   |   8 +
>  drivers/fpga/Kconfig                          |  20 +
>  drivers/fpga/Makefile                         |   6 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 669 ++++++++++++++++++
>  drivers/fpga/intel-m10-bmc-secure.c           | 557 +++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            | 201 ++++++
>  include/linux/mfd/intel-m10-bmc.h             | 116 +++
>  8 files changed, 1728 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
>

