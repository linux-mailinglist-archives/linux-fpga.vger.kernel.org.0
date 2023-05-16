Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBC7044D8
	for <lists+linux-fpga@lfdr.de>; Tue, 16 May 2023 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEPFrb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 May 2023 01:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEPFra (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 May 2023 01:47:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B11E40C5
        for <linux-fpga@vger.kernel.org>; Mon, 15 May 2023 22:47:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f423521b10so68295945e9.0
        for <linux-fpga@vger.kernel.org>; Mon, 15 May 2023 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1684216043; x=1686808043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGOXS5oeYEm1eXVEOFIbXWDzPg8PMUvacNlvjP+UFms=;
        b=iVu3Wxf06XZ3lRKy/n6RQOFfwAcXqWLQMZvIokp/GZ/cpQabpwZtzF4nf/gpUKhmJ6
         npP2ExnTGfb9Lz1fa99FUfa1O95b5QGdS7g3P/KDNBucm04zveYg2qJ5VBZ/G5p/ut/I
         CYWc4VU8abVUWH+JeRXqCtw7WI/v86wSmOrceS5BrCYqplj4O3XpeYFxoDIvZKmRIe5L
         1Y44DhhSm+DPV17s2YGfIKkHyv4w935cupOvUIVgbyAtH7CNXFt+t0h7SW5SPnsA/5SX
         Tstg8B+wE1KgmA6Gbs4LU8Sch8c3wsHdQAl4/FpwQp9SP+B26YT1L1LKINuzdnkH2Ydx
         v+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684216043; x=1686808043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGOXS5oeYEm1eXVEOFIbXWDzPg8PMUvacNlvjP+UFms=;
        b=T7Hbt/o7I/QjiOBU5hopqzH69tlLvvDt/lqV5443y/UPqFC3tg/2fVc/qeW4yCfVj9
         K5475bylsgVgNsasX+R4biA/5wEAh7CuIHASiUHANaQEZMLO230S0370oXSidaL+EUi/
         eGvtLU1ZNFYr+GdogO20W6gBpcNu75kQDOEIQDoiM8j2ZZdqZdo1ruhE4uoM+S/w0c03
         wDYC7Fx08XE4HpmqQXQsMMC/kHnbEW3EXZKhVxRnkQpcZu3i/EKtOorHOUwxITc3iytw
         f3j0VzFa9LnXirbWNlBFDU7cY+p9REB5F//OWoyOUIO4akvn6V23G/Quhkl9jXsAfrNh
         Fuqg==
X-Gm-Message-State: AC+VfDzKgFpvKZndHYFdjHyk/vLKRhyp5YLkKTneww56KcZ/N/AXosJM
        X6X+CfDhtc7upIEv2+JB4FL9uA==
X-Google-Smtp-Source: ACHHUZ7UVZh7I+HRTjlWTG+V01v8fP9MNwUWb0S81XmV8Pv1P/knSk+1bVmpRoHZkH7Onz9DRmgFbA==
X-Received: by 2002:a7b:cb92:0:b0:3f4:2374:3515 with SMTP id m18-20020a7bcb92000000b003f423743515mr21551025wmi.5.1684216043618;
        Mon, 15 May 2023 22:47:23 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d46ce000000b00304aba2cfcbsm1319495wrs.7.2023.05.15.22.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 22:47:23 -0700 (PDT)
Date:   Tue, 16 May 2023 06:47:20 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Documentation: use capitalization for chapters and
 acronyms
Message-ID: <ZGMY6LWlv8LC7zL3@equinox>
References: <20230516001518.14514-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516001518.14514-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 15, 2023 at 05:15:18PM -0700, Randy Dunlap wrote:
> Use capital letters in acronyms for CD-ROM, FPGA, and PCMCIA.
> 
> Use capital letter in the first word of chapter headings for
> Locking, Timers, and "Brief tutorial on CRC computation".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/cdrom/index.rst   |    6 +++---
>  Documentation/fpga/index.rst    |    2 +-
>  Documentation/locking/index.rst |    2 +-
>  Documentation/pcmcia/index.rst  |    2 +-
>  Documentation/staging/crc32.rst |    2 +-
>  Documentation/timers/index.rst  |    2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-next-20230515.orig/Documentation/cdrom/index.rst
> +++ linux-next-20230515/Documentation/cdrom/index.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -=====
> -cdrom
> -=====
> +======
> +CD-ROM
> +======
>  
>  .. toctree::
>      :maxdepth: 1
> --- linux-next-20230515.orig/Documentation/fpga/index.rst
> +++ linux-next-20230515/Documentation/fpga/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  ====
> -fpga
> +FPGA
>  ====
>  
>  .. toctree::
> --- linux-next-20230515.orig/Documentation/locking/index.rst
> +++ linux-next-20230515/Documentation/locking/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  =======
> -locking
> +Locking
>  =======
>  
>  .. toctree::
> --- linux-next-20230515.orig/Documentation/pcmcia/index.rst
> +++ linux-next-20230515/Documentation/pcmcia/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  ======
> -pcmcia
> +PCMCIA
>  ======
>  
>  .. toctree::
> --- linux-next-20230515.orig/Documentation/staging/crc32.rst
> +++ linux-next-20230515/Documentation/staging/crc32.rst
> @@ -1,5 +1,5 @@
>  =================================
> -brief tutorial on CRC computation
> +Brief tutorial on CRC computation
>  =================================
>  
>  A CRC is a long-division remainder.  You add the CRC to the message,
> --- linux-next-20230515.orig/Documentation/timers/index.rst
> +++ linux-next-20230515/Documentation/timers/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  ======
> -timers
> +Timers
>  ======
>  
>  .. toctree::

Hi Randy,

Thanks for the patch.

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
