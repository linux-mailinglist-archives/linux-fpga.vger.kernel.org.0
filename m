Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C73325089
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Feb 2021 14:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBYNbk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Feb 2021 08:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhBYN3w (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 25 Feb 2021 08:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614259705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cX1YwP3YWDah575YgPl8iZuouPyX+en9n47H8Xk4fEg=;
        b=EMish+SkfXuFPKG4JTmcdie6kmG8rmGVs+L9XL2EwsVpTOkwSHMRG4ANVolWyGweBzgIfY
        hQsP6FqKYzjj7Xq5EaeYj6m447s2DWkD36wvGm8gVkzHvEAUj5A1MUs8fG9wPL6F2NEBgN
        4XPhqUkpvNhCX/do7IuI3E/1kJx5g4Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-cGvvxiXmNnSIdXi6Uaiatw-1; Thu, 25 Feb 2021 08:28:23 -0500
X-MC-Unique: cGvvxiXmNnSIdXi6Uaiatw-1
Received: by mail-qt1-f197.google.com with SMTP id l1so3977317qtv.2
        for <linux-fpga@vger.kernel.org>; Thu, 25 Feb 2021 05:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cX1YwP3YWDah575YgPl8iZuouPyX+en9n47H8Xk4fEg=;
        b=YnNewNyqckHTVc11Hssm98HGfjBuAWwInEGb+C2Vf0FxuGkibB2PCWQ56KVHezHNln
         V0qOjylXWToGxGLx2rgtlJ5tPZwwqF3YIMYNaV62pkJwja0O2pHKALg9AaueeQTOy/n6
         1U+B1mBJAKywa49h6o2JnPjmihpRfmWf0eFXxXWnj35KEfFUWGufe/fnMetPT9AvpBBI
         YUP254NpIobHvMHbnjOD5GMGJjL+IhlQ6i7t7YE8R0gZZ6gjiDTcP+T6hMzhPy1PPJa6
         qJDya/rPz4VVhubNc1on6OIXTk5BR9+ZPApJesidhpC7Kh4Uurv97AHd0k9HfxTfRU0g
         pNAw==
X-Gm-Message-State: AOAM530v5rCAnrvXYc24LEQkq3SCY3gE7Guw11pYUuZWvHdhaMM9tJdc
        sZBI4PrCFzdM5sptX9W/JtxK87B3S3CMSN4ZwddKRLyluREPkyINqwj1gtx54SVsihcETtc/hHR
        nvFpgy1V1GLwtU1o4Kk5LQQ==
X-Received: by 2002:a05:622a:11:: with SMTP id x17mr2328171qtw.195.1614259702767;
        Thu, 25 Feb 2021 05:28:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfzYuOPUvjkC82O/gnNQNOcsg51uA3ltUcFvQWD7UhzwCAmIRLrsD1AWPny3rqz7qnxaxrzA==
X-Received: by 2002:a05:622a:11:: with SMTP id x17mr2328155qtw.195.1614259702568;
        Thu, 25 Feb 2021 05:28:22 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 197sm3866710qkf.33.2021.02.25.05.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:28:22 -0800 (PST)
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     "Gong, Richard" <richard.gong@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3c6d5adf-c355-f0c8-b843-5bf95f81876e@redhat.com>
Date:   Thu, 25 Feb 2021 05:28:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The first patch is a fix that is targeted for stable.

Tom

On 2/25/21 5:07 AM, Gong, Richard wrote:
> Hi Moritz,
>
> Sorry for asking.
>
> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>
> Regards,
> Richard
>
> -----Original Message-----
> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com> 
> Sent: Tuesday, February 9, 2021 4:20 PM
> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Gong, Richard <richard.gong@intel.com>
> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>
> From: Richard Gong <richard.gong@intel.com>
>
> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>
> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>
> Bitstream authentication makes sure a signed bitstream has valid signatures.
>
> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>
> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature. 
>
> Richard Gong (7):
>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>   firmware: stratix10-svc: extend SVC driver to get the firmware version
>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>   fpga: of-fpga-region: add authenticate-fpga-config property
>   dt-bindings: fpga: add authenticate-fpga-config property
>   fpga: stratix10-soc: extend driver for bitstream authentication
>
>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>  include/linux/fpga/fpga-mgr.h                      |  3 ++
>  7 files changed, 125 insertions(+), 18 deletions(-)
>
> --
> 2.7.4
>

