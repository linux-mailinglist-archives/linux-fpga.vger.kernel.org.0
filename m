Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D763A05EA
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhFHV0l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 17:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234620AbhFHV0V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 17:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sgq7YpZfI377cjTuKzZzdMcYM8vZyb+R30zx+84A9yI=;
        b=aesv95Fzj7RXjeqKz2xQDZMQBMcOd1y6qd8CFBKBq4lPa0HYLQqb2Xw7wtubgxrhk38Opi
        TzTkwTDJS1ve2u/XvEsOxmJIkrx24z8XhdXI8bsd0qQzfmyubTeAJGSrz+W4QfYEXo04aN
        A+/ARvTtD7T0klj22UXl51+KJFtnyr8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-ElMYJd7GNqqSWYj96W9qeA-1; Tue, 08 Jun 2021 17:24:26 -0400
X-MC-Unique: ElMYJd7GNqqSWYj96W9qeA-1
Received: by mail-oo1-f70.google.com with SMTP id t19-20020a4ae4130000b029023950cb8d35so14062032oov.6
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 14:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sgq7YpZfI377cjTuKzZzdMcYM8vZyb+R30zx+84A9yI=;
        b=pCKyJoOfUiBBl9IRy/i4HTg0CFVTIES60XlFF7G7yoqr3nxDH/GFKiY0oItwHdOT5r
         rmbnqsdY9X/ozcqt8cTSNQrmV51NugqJnmEnKz2j14es+F5ZRTmDrVpWsUZIp4c0swwS
         WengPASfzjuxZgnybbU2pt4PyZAURL4oen9PCg64tZVrWEsyU6lVKCm4T0FO2Df4dXNk
         TSXI1idNWyXkNJieh0swQ5lEm8y1uYs1geOBKxMph/YsUwsxd1rh+pyBvjqDNRU7lvr9
         uYrbnhyMxJlMIfiJyMchpG7YeZfpLCrlNMlnmOdW8Xv6l9NkPtOpGt0MK6wXg7NDgDP5
         E9QA==
X-Gm-Message-State: AOAM532PYKpvutgj1CDUHaxiorplFjQSAy7SCN2+aN//Mr9VeQ/+96q4
        613DSVDbQezYysNy7wNedHl72E9ZJsHuF01PIXGQsVKO+N+8NNTEEVO5fXeU2UuN8P6D1H5SjWx
        vRH8P/tVfSPHQUOq6olcnIg==
X-Received: by 2002:aca:33d4:: with SMTP id z203mr4176764oiz.51.1623187465853;
        Tue, 08 Jun 2021 14:24:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysr+C3bZgIQEZy/8wCr9Q5uLj3VqD8M6xSNa0dsASWBdlkV/63bU+lwSL+xyqD9OEYmwRjzg==
X-Received: by 2002:aca:33d4:: with SMTP id z203mr4176741oiz.51.1623187465720;
        Tue, 08 Jun 2021 14:24:25 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:25 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 10/11] fpga: stratix10-soc: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:49 -0700
Message-Id: <20210608212350.3029742-12-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/stratix10-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c5fc996..2aeb53f8e9d0f 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -271,7 +271,7 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
 }
 
 /*
- * Send a FPGA image to privileged layers to write to the FPGA.  When done
+ * Send an FPGA image to privileged layers to write to the FPGA.  When done
  * sending, free all service layer buffers we allocated in write_init.
  */
 static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
-- 
2.26.3

