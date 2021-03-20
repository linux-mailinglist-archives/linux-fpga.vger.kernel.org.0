Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1B342D62
	for <lists+linux-fpga@lfdr.de>; Sat, 20 Mar 2021 15:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCTOfq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 20 Mar 2021 10:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhCTOfX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 20 Mar 2021 10:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616250923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTH6ojkJ/FhOGgrVKVnkg3Ly8cmBRmLIU0P35pmiizM=;
        b=fyl2ZBp+FEcF70x3uhoaPuzL1IS8Z99rIRd29jHQ9XegJ9dtjiFNFPlpccbLjmtxOgaPDr
        bV3SQ9uEz3O2UQED/WCAG4jD8XAZqG43S5ixF9GzSH0F0FviVW6qmu8YgaGJGLVOfPgI5s
        TVEtIoYfXtd74tCTz+xwRXwJJ9p+HE0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-YbhbavXUPNiVxEcd69-n_w-1; Sat, 20 Mar 2021 10:35:21 -0400
X-MC-Unique: YbhbavXUPNiVxEcd69-n_w-1
Received: by mail-qt1-f199.google.com with SMTP id p10so13054920qtq.12
        for <linux-fpga@vger.kernel.org>; Sat, 20 Mar 2021 07:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kTH6ojkJ/FhOGgrVKVnkg3Ly8cmBRmLIU0P35pmiizM=;
        b=TPOyarZY+/F0uWDSty056DWguKLyQ+rmUJj9D/4GVOco3waX2YVZlRbY1vib+ecIe6
         MJ3TKBZa5L4UQaBoS989hCczYB1ehATFcwmWQUtrF/k3jNnt4j23L79Us8VsgBzQKrVg
         4fvj/HqcMuhL8F7+ieAaAw1YiKg1XqkPB2iG799QmExnRL8mLjN31SJLxyJS/ZBOeD9e
         a26LueNu9NKlD4Z/S3jKONcvrfXWp/R4e5iwB/1MLNPOtxfc77iVrk3vaiv8Sf6HXxlb
         b8ju0Qy7YptZsbv6mXpWa8B48B8jQXEfipwk88UqxaN4m2VKr3VsaEIfwiuMT7tqyrLr
         pqUQ==
X-Gm-Message-State: AOAM532YyRf1pWcIyRGdTKXxyWnDeAksAyVI8p2tCXrgyn6DCBlCz1GV
        B75sgQzINOx+E3pHo3pPJAsh3t4cgFiJph2kZ/PF77rqlF4kqZFdkZtoybN/JYIU6H1laoqeCij
        7BhMZQDn7yKeUBq5YaiY0oA==
X-Received: by 2002:a05:620a:91b:: with SMTP id v27mr3244123qkv.201.1616250920970;
        Sat, 20 Mar 2021 07:35:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvA/zKytEJQ3qZA6AO7gI+5irbUVxXQrI2rsh06j5f7tDHOk/0A5geKSWsBrWIdoMEzTGO3w==
X-Received: by 2002:a05:620a:91b:: with SMTP id v27mr3244100qkv.201.1616250920729;
        Sat, 20 Mar 2021 07:35:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h6sm5732843qtj.75.2021.03.20.07.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 07:35:20 -0700 (PDT)
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     Richard Gong <richard.gong@linux.intel.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <21a8817a-e63e-6029-69a6-6bae5398439a@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1d7fd02b-4ef2-8d11-fba7-87a698699978@redhat.com>
Date:   Sat, 20 Mar 2021 07:35:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <21a8817a-e63e-6029-69a6-6bae5398439a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/19/21 4:22 PM, Richard Gong wrote:
>
> Hi Moritz,
>
> Thanks for approving the 1st patch of my version 5 patchest, which submitted on 02/09/21.

This change

e23bd83368af ("firmware: stratix10-svc: fix kernel-doc markups")

Makes a lot of formatting changes in the same files as this patchset, including the first patch.

It would be good to try applying this patchset to char-misc-next and resubmit if there are conflicts.

>
> Can you help review the remaining 6 patches from the same version 5 patchset? I need your ACKs to move forward, or please let me know if additional work is need.

These changes look good to me.

I was looking at the patchset again seeing if the firmware/ parts could be split out.

Even though stratix10 is a fpga, from the MAINTAINERS file it is not clear to me if linux-fpga owns them and they come in on Moritz's branch.  I think this change is needed to the MAINTAINERS file to make that clearer.

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..1f68e9ff76de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9193,7 +9193,8 @@ F:    tools/power/x86/intel-speed-select/
 
 INTEL STRATIX10 FIRMWARE DRIVERS
 M:    Richard Gong <richard.gong@linux.intel.com>
-L:    linux-kernel@vger.kernel.org
+R:    Tom Rix <trix@redhat.com>
+L:    linux-fpga@vger.kernel.org
 S:    Maintained
 F:    Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
 F:    Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

I also added myself as a reviewer because I want to help out.

Tom


>
> Many thanks for your time again!
>
> Regards,
> Richard
>
>
> On 2/25/21 7:07 AM, Gong, Richard wrote:
>> Hi Moritz,
>>
>> Sorry for asking.
>>
>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>>
>> Regards,
>> Richard
>>
>> -----Original Message-----
>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com>
>> Sent: Tuesday, February 9, 2021 4:20 PM
>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Gong, Richard <richard.gong@intel.com>
>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>>
>> From: Richard Gong <richard.gong@intel.com>
>>
>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>>
>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>>
>> Bitstream authentication makes sure a signed bitstream has valid signatures.
>>
>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>>
>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature.
>>
>> Richard Gong (7):
>>    firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>    firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>    firmware: stratix10-svc: extend SVC driver to get the firmware version
>>    fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>    fpga: of-fpga-region: add authenticate-fpga-config property
>>    dt-bindings: fpga: add authenticate-fpga-config property
>>    fpga: stratix10-soc: extend driver for bitstream authentication
>>
>>   .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>   drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>   drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>   drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>   include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>   .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>   include/linux/fpga/fpga-mgr.h                      |  3 ++
>>   7 files changed, 125 insertions(+), 18 deletions(-)
>>
>> -- 
>> 2.7.4
>>
>

