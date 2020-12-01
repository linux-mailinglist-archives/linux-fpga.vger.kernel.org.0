Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5372C967D
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 05:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgLAE2E (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Nov 2020 23:28:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36186 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgLAE2D (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 Nov 2020 23:28:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id q3so456091pgr.3;
        Mon, 30 Nov 2020 20:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XT7qPo4SGXKCq6WGsdPJ15AKTgAIRFMM6hQ6UeCR5IA=;
        b=axcuFVJs0KvUotSxC9mCU1sN2GfddPuLcuF05gM3w3D1WVH8bafqYvJlVw5NFUnkuK
         MUJfo1IhLLASK83t7LKwzbMHTe6qJiURQqVR5xrCzWYdzub9I28g7riOiEf0Pw8l4F51
         Ic7Fbeynr6KiFYoUAyQvXIP/RBlODS4JpiCgvxDvwIn558FFCC50X71dymXQ/ylGYB6I
         69y6JNUAGQmmPMSTPN5qevjf24ufUklElmXcsZZ0UvhbwCyiKmU99BiWa/3XeP+31g+m
         2eorzcmvpIm884XJ233G5LhqifEwQAKNQE53hJe9Bzey0bfSbBfa0FAhp+46E1Sa7034
         r+oQ==
X-Gm-Message-State: AOAM531KYhM1Rj3bWt1DnOhhlVYOeW2MCkv3iOGTwpPg98pLcB//o+uw
        oxiz16JfS3ZFhTiKpAkD6tk=
X-Google-Smtp-Source: ABdhPJxHYUPjg2ZPY3ZtH02J8vfeX9L6+Zq05J7yUCzOiaXJK4R+79fSUpxWc3YgrqNUOZstx9VQUg==
X-Received: by 2002:a63:b60:: with SMTP id a32mr665828pgl.275.1606796836967;
        Mon, 30 Nov 2020 20:27:16 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id l1sm529559pju.48.2020.11.30.20.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 20:27:15 -0800 (PST)
Date:   Mon, 30 Nov 2020 20:27:15 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Sonal Santan <sonal.santan@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, lizhih@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org
Subject: Re: [PATCH Xilinx Alveo 2/8] fpga: xrt: Add UAPI header files
Message-ID: <X8XGI7yRAX+xAeqQ@archbook>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-3-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129000040.24777-3-sonals@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Sonal,

On Sat, Nov 28, 2020 at 04:00:34PM -0800, Sonal Santan wrote:
> From: Sonal Santan <sonal.santan@xilinx.com>
> 
> Add XRT UAPI header files which describe flash layout, XRT
> mailbox protocol, xclBin/axlf FPGA image container format and
> XRT management physical function driver ioctl interfaces.
> 
> flash_xrt_data.h:
> Layout used by XRT to store private data on flash.
> 
> mailbox_proto.h:
> Mailbox opcodes and high level data structures representing
> various kinds of information like sensors, clock, etc.
> 
> mailbox_transport.h:
> Transport protocol used by mailbox.
> 
> xclbin.h:
> Container format used to store compiled FPGA image which includes
> bitstream and metadata.

Can these headers be introduced together with the code that uses them as
logical change?

I haven't looked too closely, but it helps reviewing if you can break it
into smaller pieces that can stand by themselves.

Thanks,
Moritz
