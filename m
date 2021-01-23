Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD55301621
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Jan 2021 16:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbhAWPDA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Jan 2021 10:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbhAWPC5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 23 Jan 2021 10:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611414089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBK6oap91uhZBFVpWQoFUbolQ0lmTHn7hju0oED3gIY=;
        b=UkUCEcHHKyW59iQou7HmCXy0V7p5HUedgBBTU8s5F8pQaeI2TxW25BcJVYZdfer5yh7wRZ
        ag7ufd7H4jWhDx5XAvcuPFZ4u+wrU259eoywD6c0PsRHlUudhdSne+IMzeWHB8LDOPdIuO
        sMWWmQtIkweBil8E17m0XFjFuJCptfI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-VoxB-PSdMLuRht7iakQWOQ-1; Sat, 23 Jan 2021 10:01:28 -0500
X-MC-Unique: VoxB-PSdMLuRht7iakQWOQ-1
Received: by mail-qv1-f70.google.com with SMTP id dj13so5009769qvb.20
        for <linux-fpga@vger.kernel.org>; Sat, 23 Jan 2021 07:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UBK6oap91uhZBFVpWQoFUbolQ0lmTHn7hju0oED3gIY=;
        b=Mu9OZPf1qCILCwlUt4Nlkpkbqxc5oehIxz/lza6DxS/rlMVRnMpt4B/wSHf6joC+/b
         WxVyuUQ54OVAbDwoL0U62AlrNSlE9yXsSKO98Nr2UUykRcEcCoHT/bQ0S/C0J4/gjfG4
         7fUTTeEetWHBFl1MwJLzDUYYH0AbukOmPWpfLmpy0keNY0otxJQxuvG+DE8EWCZfdtjZ
         bOs9CG/olMjPbhnucTIWUtGq88MKtxJnM0dGQA4ZgHB75InrmwCUlFN9WRpiEQVqseWP
         7qTMPSgxhFyQ8hl9C8YV76l5tszdEm86hXw+3aC/Qy1wWRZ7IDSYfjXxV1U0LDaot3ER
         Xjjg==
X-Gm-Message-State: AOAM5316TrEeqUoAxx3Blhohly5Ib/25LYTtik4tyqGuEanj7WYKULMr
        peAVphKeY/x6BVPhmtJqYg9dFMDqODpddbbw+Td7a5WrM4Nf1izZPpoX9RYZ+w2Wah1Jf+JQ3Ac
        rmJz3FgzV1qJXf+M941XEIA==
X-Received: by 2002:aed:3aa8:: with SMTP id o37mr472702qte.239.1611414087470;
        Sat, 23 Jan 2021 07:01:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcV80cstVcywKxotrua0pjQkoaHznaZMMplTdLX0CgSnWV8PURgH6Vc4WqaiCjDvbd3By6gQ==
X-Received: by 2002:aed:3aa8:: with SMTP id o37mr472642qte.239.1611414086697;
        Sat, 23 Jan 2021 07:01:26 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x49sm8245172qtx.6.2021.01.23.07.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:01:26 -0800 (PST)
Subject: Re: [PATCH v2] MAINTAINERS: Add FPGA SUBDEVICES
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
References: <20210122192928.1651254-1-trix@redhat.com>
 <YAtlRV+0FWrVoaRc@archbook>
From:   Tom Rix <trix@redhat.com>
Message-ID: <96a9d3d9-6091-47c9-21f9-0cfdd9464732@redhat.com>
Date:   Sat, 23 Jan 2021 07:01:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAtlRV+0FWrVoaRc@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/22/21 3:52 PM, Moritz Fischer wrote:
> On Fri, Jan 22, 2021 at 11:29:28AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Every FPGA has several subdevices in other subsystems.
>> The new FPGA subdevices section is necessary to ensure changes to
>> the subdevices files get reviewed within the context of the FPGA
>> subsystem.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> v1: Add several more subdevices
>> ---
>>  MAINTAINERS | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 17ac5bdce521..96d6f00b0584 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6975,6 +6975,17 @@ F:	drivers/fpga/
>>  F:	include/linux/fpga/
>>  F:	tools/testing/selftests/drivers/fpga/
>>  
>> +FPGA SUBDEVICES
>> +R:	Tom Rix <trix@redhat.com>
>> +L:	linux-fpga@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>> +F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
>> +F:	drivers/hwmon/intel-m10-bmc-hwmon.c
>> +F:	drivers/memory/dfl-emif.c
>> +F:	drivers/mfd/intel-m10-bmc.c
>> +F:	include/linux/mfd/intel-m10-bmc.h
>> +
>>  FPU EMULATOR
>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>  S:	Maintained
>> -- 
>> 2.27.0
>>
> All these subsystems have maintainers, I think that's up to them.
> Ideally each of those drivers behaves like a normal device in the
> corresponding subsystem and the way it's implemented doesn't matter.
>
> Plenty of other examples for that
>
> drivers/net/ethernet/xilinx/*

This device has a specific maintainer, the files listed above to do not.

So any review or maintenance falls to the subsystem maintainer who likely is not be aware of it fitting within an fpga card.  They certainly will not have the hardware to test if the changes effect the card.

So until they have specific maintainers, I would like to help fill that gap by making sure they at least have a review.  Sending the changes to the linux-fpga mailing list will allow others interested in their specific fpga card to also weigh in.

The specific reason for doing this now is several in-flight changes are being made to

include/linux/mfd/intel-m10-bmc.h

That effected a couple of fpga subdevices and conflicted with Russ' security manager patchset.  To help resolve the conflict I had to track down all the in flight changes.  If I had been on the reviewer list for the file or the patch had been mirrored to linux-fpga, I would have been notified of the changes earlier and finding the conflict would have not been as difficult.

Since we are pushing subdevices to the subsystem, I think we should also be encouraging subdevices to be maintained by the submitter and if they are not, they get added to the subdevices list so all the work is not done by the subsystem maintainers.

Tom

>
> for example.
>
> - Moritz
>

