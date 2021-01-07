Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8702F2ED403
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbhAGQLI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Jan 2021 11:11:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728491AbhAGQLI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Jan 2021 11:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610035782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXoJUH9nb/5s3OhI5AP+cCvXW3KV/5X1dm5BDpD0/j4=;
        b=gpzS4YJy3K/y4aW06vWhZ2zzVKxW3JUkWYyAm/bABDeQeGA308enzOHmc9oGokBLec7QzA
        8cMt1Q/CYB8a9MpMwK5L0zH5szEksz3ke4cVJ4wywa8LuiLqBrAMNNxEFjLzGlKdvw5/Gd
        Zv8yXkQq8PdNdMTKdBxjxbKsQmHWnRY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-3NnxxyseP-OuUYvkMECiNA-1; Thu, 07 Jan 2021 11:09:14 -0500
X-MC-Unique: 3NnxxyseP-OuUYvkMECiNA-1
Received: by mail-pf1-f199.google.com with SMTP id y187so4422178pfc.7
        for <linux-fpga@vger.kernel.org>; Thu, 07 Jan 2021 08:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cXoJUH9nb/5s3OhI5AP+cCvXW3KV/5X1dm5BDpD0/j4=;
        b=HMB2Fd1LfShVbALUKl3Gje//2uqQb+9kviF06FnemFteprSaoLDBeG4tti6FQclzW8
         sInbwYjLxLxdxflm36dnZNV16wBgYrGuXnMHbj252aMvOcKx6TkgQwbUOJTcZtwmV9rW
         0ar0mIqQUb8rCUxL1In9q1b5Y2OlsaDSTQU/mrYjje7DxBIuVmziN7XafVfObL8QXCC1
         FiOA0kK76lm+u662qhYQPd2S0h9NX6toeyPcnL63Zk0UOj8E+wxQt+TqCR7ovavRUhPJ
         s3x9L+D4VveftU5wZe/V0nZcg+XwSvh5xPaSMmYBR7sNtMF9cXqmtP3hJNKzeirpdto9
         /NmA==
X-Gm-Message-State: AOAM531R7SQHBd8DsmX6UNjEz+nlqxoZOd+2Uu8mBqgnTHC6zE/M/O3A
        W7YGvx7mCFNyXxl//jJnI8b6LUTAT4icXFz6lY3G4rzEwNINNsFCsphuKjW9RvggrjWsvpd4O0g
        KzTZN+40PrRs6F2QzVjsf1Q==
X-Received: by 2002:a17:902:aa84:b029:da:f114:6022 with SMTP id d4-20020a170902aa84b02900daf1146022mr2763329plr.46.1610035753861;
        Thu, 07 Jan 2021 08:09:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW1DtzbZben3b+C+8kukp3vOiFY8Eplbbo86mLqsB8eougaXGrrkDWq3GjEDVVOFhveSFc9g==
X-Received: by 2002:a17:902:aa84:b029:da:f114:6022 with SMTP id d4-20020a170902aa84b02900daf1146022mr2763314plr.46.1610035753663;
        Thu, 07 Jan 2021 08:09:13 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i10sm7017924pgt.85.2021.01.07.08.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:09:13 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        moritzf@google.com
References: <20210107043714.991646-1-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
Date:   Thu, 7 Jan 2021 08:09:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210107043714.991646-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/6/21 8:37 PM, Moritz Fischer wrote:
> This is a resend of the previous (unfortunately late) patchset of
> changes for FPGA DFL.

Is there something I can do to help ?

I am paid to look after linux-fpga, so i have plenty of time.

Some ideas of what i am doing now privately i can do publicly.

1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.

2. an in-flight dev branch for the outstanding patches 

Tom


