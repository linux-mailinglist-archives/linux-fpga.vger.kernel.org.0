Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF6E306697
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 22:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhA0Vny (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 16:43:54 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:52229 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhA0VmP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 27 Jan 2021 16:42:15 -0500
Received: by mail-pj1-f49.google.com with SMTP id kx7so2166656pjb.2;
        Wed, 27 Jan 2021 13:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWgqcKpieQkXMDPWiLObF178Q3qLs3aTssPJIHcxG5k=;
        b=EPDUujR4DoE1RRyKUn2ybUGEKcqlO62WE5ISYCY7Oxt9urLiRKV2m814eVXngrDqkt
         Jx8X8QnXyCKZlXPUUZXx0PtqZFAuNsBBL4SGIXxHD7otsuTTC7j96VjJgf6QqtAKImK9
         L+DM6Cp/j73fXB1mOPsNtSkrPzyfP2kIohcjvzeosljMG1F7qDfu7B5QFNjXLwaqVK8M
         zbmJAKVMUPPI08I+UGLSjj7X0cIf7FB9aicowep51zNcE6laL6uwijatXkmJallheGz/
         5UUGNQgR1ZJ488HAaIJTk2EZNxKkzzm8fVYWlaR9WcNmojJ4xdoyN3m6lGwAmWx+2W9a
         LdGg==
X-Gm-Message-State: AOAM5311iyI0zLkmZaa52x4cRVi3g/hBl6tuJTz3eKDgytfuPbPiQ3/n
        xEJkG4PUrljTIcERAen2ToY=
X-Google-Smtp-Source: ABdhPJy6kHTtCQ6TEXd97/rsQm+bNVWRniIGyCrNvQF2qRT3InEq8jAkQzP44rpzVyTObGh2PKrstA==
X-Received: by 2002:a17:902:7207:b029:da:fd0c:521a with SMTP id ba7-20020a1709027207b02900dafd0c521amr13040751plb.45.1611783694759;
        Wed, 27 Jan 2021 13:41:34 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id p64sm3242599pfb.201.2021.01.27.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 13:41:33 -0800 (PST)
Date:   Wed, 27 Jan 2021 13:41:32 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mdf@kernel.org,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 1/6] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
Message-ID: <YBHeDF7p8QKu83tP@epycbox.lan>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
 <YBFW50LPP/yEbvEW@kroah.com>
 <2f9d082b-9970-8f41-0351-324f1bad6cbf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9d082b-9970-8f41-0351-324f1bad6cbf@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 27, 2021 at 07:05:41AM -0600, Richard Gong wrote:
> 
> Hi Greg,
> 
> Thanks for review!
> 
> On 1/27/21 6:04 AM, Greg KH wrote:
> > On Mon, Jan 25, 2021 at 02:56:23PM -0600, richard.gong@linux.intel.com wrote:
> > > From: Richard Gong <richard.gong@intel.com>
> > > 
> > > Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
> > > authentication feature. Authenticating a bitstream is to make sure a signed
> > > bitstream has the valid signatures.
> > > 
> > > Except for the actual configuration of the device, the bitstream
> > > authentication works the same way as FPGA configuration does. If the
> > > authentication passes, the signed bitstream will be programmed into QSPI
> > > flash memory and will be expected to boot without issues.
> > > 
> > > Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> > > aligns with the firmware settings.
> > > 
> > > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > > ---
> > > v3: no change
> > > v2: new added
> > > ---
> > >   include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
> > >   1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> > > index ebc2956..7ada1f2 100644
> > > --- a/include/linux/firmware/intel/stratix10-svc-client.h
> > > +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> > > @@ -51,12 +51,17 @@
> > >   #define SVC_STATUS_NO_SUPPORT		6
> > >   /*
> > > - * Flag bit for COMMAND_RECONFIG
> > > + * Flag for COMMAND_RECONFIG, in bit number
> > >    *
> > >    * COMMAND_RECONFIG_FLAG_PARTIAL:
> > > - * Set to FPGA configuration type (full or partial).
> > > + * Set for partial FPGA configuration.
> > > + *
> > > + * COMMAND_AUTHENTICATE_BITSTREAM:
> > > + * Set for bitstream authentication, which makes sure a signed bitstream
> > > + * has valid signatures before committing it to QSPI flash memory.
> > >    */
> > > -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> > > +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
> > 
> > So is this a bugfix, changing this value to the correct one?
> 
> Yes, it is a bug fix.
Wat? This is a change in interface spec with the firmware. I thought the
whole point of the firmware version SVC call was to prevent breaking old
firmware?

Didn't we discuss this earlier?

> > 
> > If so, shouldn't this be a stand-alone patch and get backported to
> > stable kernel releases?
> 
> Sure, I will make change and submit again as a standalone patch.
> 
> > 
> > If not, then no one uses this flag today?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Regards,
> Richard

- Moritz
