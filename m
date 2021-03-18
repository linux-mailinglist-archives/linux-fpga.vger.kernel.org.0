Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D5340AC5
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Mar 2021 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhCRQ6J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Mar 2021 12:58:09 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:53000 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhCRQ5p (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 Mar 2021 12:57:45 -0400
Received: by mail-pj1-f51.google.com with SMTP id ha17so3250113pjb.2;
        Thu, 18 Mar 2021 09:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0q+2CTjMEu7J7YrQZi1WDnvtnvNsrIPA5dPfOFobHqo=;
        b=f5vzqtj6+tfnmeJHzRm1iEycYW29mgr5S9pIF0bNxDPzaf2+C6R8lnT87ffasKAr8f
         knZJ8IHm6v5PvCMe+M17MfGtFwLbqcvcwiOaOrmvUBUoCPiS2jbWCS0zBxt+9l9NyRKq
         yYmfSFHAyrF+d3u4y2lkaNUbMjCJbXUDgA4aMidCc72Wc5pLx9Dyk/cFG4gMXoK+CjSw
         1OWs0RA6BVmVvND/gHHiKNrpq+Gw0QI+pt+sbdnjr7NwbhEdN1XZ5mb6aLnC/8nGvH25
         URd22izEltk8Ami2IrvPpovSsXSb3jtTts8+8GgBgJQ/6V6YFZ7yFDjT1JNX3NWEh2p0
         zrfQ==
X-Gm-Message-State: AOAM5306C30hk77uSMkpr8CUwl+QckX+g4nHDdpTbc7cOr3PbEzvkH99
        9qrNC96ZWu8xIPHxpuSl4cm5o8tJtXA=
X-Google-Smtp-Source: ABdhPJwM0IeGiLmhyJtodbh+8GNJSk3qZ5khKEAsUSEwziL/ATYnkdIE8lKKLKx3CV/tESYnG96CLA==
X-Received: by 2002:a17:90a:d311:: with SMTP id p17mr5337697pju.43.1616086665004;
        Thu, 18 Mar 2021 09:57:45 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id fv9sm3533407pjb.23.2021.03.18.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:57:44 -0700 (PDT)
Date:   Thu, 18 Mar 2021 09:57:43 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Richard Gong <richard.gong@linux.intel.com>, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv5 1/7] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
Message-ID: <YFOGh+KKYcp17aeB@epycbox.lan>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <1612909233-13867-2-git-send-email-richard.gong@linux.intel.com>
 <bc43e8ab-b8df-fd2f-31e4-02cdc48cadff@redhat.com>
 <3ff3e9ca-cdca-796e-0b57-5010963e7ee1@linux.intel.com>
 <12eb2031-db0a-4c00-117e-f3ee8dd15978@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12eb2031-db0a-4c00-117e-f3ee8dd15978@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 15, 2021 at 06:32:16AM -0800, Tom Rix wrote:
> 
> On 2/15/21 6:41 AM, Richard Gong wrote:
> > Hi Tom,
> >
> > On 2/13/21 9:44 AM, Tom Rix wrote:
> >>
> >> On 2/9/21 2:20 PM, richard.gong@linux.intel.com wrote:
> >>> From: Richard Gong <richard.gong@intel.com>
> >>>
> >>> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> >>> aligns with the firmware settings.
> >>>
> >>> Fixes: 36847f9e3e56 ("firmware: stratix10-svc: correct reconfig flag and timeout values")
> >>> Signed-off-by: Richard Gong <richard.gong@intel.com>
> >>> ---
> >>> v5: new add, add the missing standalone patch
> >>> ---
> >>>   include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> >>> index a93d859..f843c6a 100644
> >>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> >>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> >>> @@ -56,7 +56,7 @@
> >>>    * COMMAND_RECONFIG_FLAG_PARTIAL:
> >>>    * Set to FPGA configuration type (full or partial).
> >>>    */
> >>> -#define COMMAND_RECONFIG_FLAG_PARTIAL    1
> >>> +#define COMMAND_RECONFIG_FLAG_PARTIAL    0
> >>
> >> Is this the stand alone fix split from v3's patch 1 ?
> >>
> >> https://lore.kernel.org/linux-fpga/YBFW50LPP%2FyEbvEW@kroah.com/
> >> Yes, it is a stand-alone patch.
> 
> Thanks.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> >
> >> Tom
> >>
> >>>     /**
> >>>    * Timeout settings for service clients:
> >>
> > Regards,
> > Richard
> >
> 

Applied to fixes.

Thanks,
Moritz
