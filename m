Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7C36AA42
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Apr 2021 03:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhDZBWB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Apr 2021 21:22:01 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:40770 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDZBWB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Apr 2021 21:22:01 -0400
Received: by mail-pj1-f49.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so4181942pjx.5
        for <linux-fpga@vger.kernel.org>; Sun, 25 Apr 2021 18:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6lI+Ve/SHANKfZQOItn5KJHkZlLTv8/u+x1gPL3sz7g=;
        b=TLEZAkG6zajVT/BG+tBv4CO6DzW17UPcPkr8hWfLSrU1Hsnuuax8LnhyMP1YHKxw/n
         i7daN5ytKeV2Qqc8zALAvJ3Jrw8HkBxD1Ev0eeAeiVTQnGim6h+SuNxJs7kyqzQpw8r9
         uJJQ4ZQDsZCkdIt7psj6/hRAfqB4RaZt+dtsiN2/+KE7zNYAIIaAJ6Z51wrp4NjmMVLK
         wrfAw6xtcSyiEBvy2h/+II2zi0zD7t6RnwHQO3/M2rnuxR4t0o4knnYK5Kiw6qZEix6M
         WXv1NhYnW040hsF21Yl6Eym09ZMQXX9dtBYCkFsZIEWKHCWetmj54w1gAro4L5q2A6Fu
         9x8Q==
X-Gm-Message-State: AOAM53060Td0pFkoFBjdqu8K08xXG6oa3mt0Vg+LOvNMmbmD0QEhyL7N
        8TnMyU62FIgV0LolyeMkzyU=
X-Google-Smtp-Source: ABdhPJz4mOqcud+eMrpczKI4jxQN7JJIk59DD++TZMPdFaIbkgLPyHrH6tzUW8XLZzPPw3ikevPB1g==
X-Received: by 2002:a17:90a:4290:: with SMTP id p16mr19642453pjg.120.1619400080278;
        Sun, 25 Apr 2021 18:21:20 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c21sm9415409pfc.165.2021.04.25.18.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 18:21:19 -0700 (PDT)
Date:   Sun, 25 Apr 2021 18:21:15 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
Subject: Re: [RFC PATCH v1 0/1] Extend FPGA manager with async image updates
Message-ID: <YIYVi9dfwtwKmapp@epycbox.lan>
References: <20210410003810.222597-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410003810.222597-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Fri, Apr 09, 2021 at 05:38:09PM -0700, Russ Weight wrote:
> Hi Moritz,
> 
> This RFC patch is a follow-on to my evaluation of the possibility of merging
> secure update functionality into the FPGA Manager. My earlier RFC email
> is here: https://marc.info/?l=linux-fpga&m=161783978715092&w=2.
> 
> This RFC patch implements the core fpga_sec_mgr_update() function from the
> security manager patchset:
> https://marc.info/?l=linux-fpga&m=161525020621455&w=2.
> 
> Specifically, it is a port of this patch:
> https://marc.info/?l=linux-fpga&m=161525020721457&w=2
> 
> I think this patch provides enough context for further discussion. It
> extends functionality without leveraging any common code (because I
> didn't see an opportunity to share code).
> 
> In this patch, I am using the term "async" (in reference to the kernel
> worker thread) instead of the term "security". While the security manager
> patches were originally created specifically to support Intel secure image
> updates, there is nothing inherently secure about the driver support, other
> than the fact that the operation is essentially atomic: one write to the
> "filename" sysfs entry is all that is required from user-space to do
> an update. Our convention is to use signed, self-describing images that are
> interpreted by the card BMC, but one could use a non-signed image or even
> interpret the contents of the image based on the context of the parent
> driver. I think the main differentiating factors are:
> 
> (1) sysfs interface: an update is an atomic operation accomplished with a
>     single write.
> (2) self-describing: The type of information contained in the FPGA Manager
>     fpga_image_info structure would have to be included in the image file
>     and interpreted by the parent driver (not the class driver).
> (3) asynchronous: A write to the "filename" sysfs node write will return
>     immediately and the update will proceed in the context of a kernel
>     worker thread. Additional sysfs interfaces would be used to monitor the
>     progress and determine the ultimate success or failure of the update.
> (4) No notion of regions, bridges, or FPGA state. For Intel PAC cards, some
>     image files don't even contain an FPGA image. If they do, the image could
>     become active on the next power-cycle, or it could be activated through
>     some other trigger mechanism.
> 
> Can existing ops be leveraged?
> ==============================
> write: The current write op _could_ be used if the prototype were modified to
> accept an additional offset parameter. For the async update, writes are done
> in chunks, and the target offset needs to be passed on each write.
> 
> write_init and write_complete _could_ be used without change.
> 
> Other ops would have to be added: cancel, cleanup, hw_errinfo
> 
> I chose to implement all new ops because of the return data types. The fpga-mgr
> ops use the standard negative errno values. More descriptive and relevant error
> information can be provided via sysfs by defining a set of enum error codes.
> For example, it is very helpful to be able to tell the user that they are in a
> FLASH-wearout state, but standard errno values do not facilitate the
> communication of a wearout error.
> 
> Would it be better to share the two or three ops that can be shared, and be
> content with the standard error numbers? Or is it OK to use separate ops?
> 
> Should async updates be available via exported symbol?
> ======================================================
> As I understand it, current image updates through the FPGA Manager are all
> started with a call to the exported symbol fpga_mgr_load(). It would be
> possible to export an fpga_mgr_async_load() symbol, but there would need
> to be additional exported symbols to facilitate the collection of status
> information. Is there a use case for this?
> 
> Can a common update function be used?
> =====================================
> fpga_mgr_async_update() is analagous to fpga_mgr_load(). However, all async
> updates use the request_firmware framework. The FPGA Manager supports two
> separate flows: a single image buffer or scatter-gather. It would be possible
> to integrate these features for async updates, but I'm not sure that there is a
> need for such functionality.
> 
> I look forward to your feedback. Do you see value in integrating the two
> drivers? Should I continue this process?
> 
> - Russ
> 
> Russ Weight (1):
>   fpga: mgr: enable asynchronous image updates
> 
>  .../ABI/testing/sysfs-class-fpga-manager      |   9 +
>  drivers/fpga/fpga-mgr.c                       | 199 +++++++++++++++++-
>  include/linux/fpga/fpga-mgr.h                 |  52 +++++
>  3 files changed, 259 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.1
> 

Apologies for the late reply, was out on vacation.

Will take a look at this this week.

- Moritz
