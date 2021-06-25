Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC53B498D
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFYUB3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 16:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhFYUB1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624651146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06yao2CDsis15QoJOXCwwfY4/53M6JaTIu7lUfBh14M=;
        b=C4xRghxzE13EJ0cSapJpfYW5rL01DQTdPI5fxg+ThN6kHDCbBuIl1ncQuTEHAT0Luc3x2J
        L6YdZsqelnlWp0koIbs29998Ai3x5wktxKP+WGkUfOayXh7nuQPyu8FHscAB0zuXvH88/T
        VK0ZAjOKmo8n65QKXzMsCYaO6Py/wkg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-kLyAyr-INRq86r2_9QzZ8Q-1; Fri, 25 Jun 2021 15:59:05 -0400
X-MC-Unique: kLyAyr-INRq86r2_9QzZ8Q-1
Received: by mail-oi1-f200.google.com with SMTP id a204-20020acab1d50000b0290239d39cfa6cso5346567oif.20
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06yao2CDsis15QoJOXCwwfY4/53M6JaTIu7lUfBh14M=;
        b=d8U7WN3rCRTjYlTDNq1fknxrWFEfu+YfDGf4Q2vXcgtT1kboxdMdzXLENrZiWTmPmF
         Mwayriu+1/W2nXmYlXFB9P9L89AqA1J+GeeW702wxY+21I447tD3uTPdAs0KxhRinFa+
         tAY3vQwPgppCAqRyaFA5fSaXQyFBZK62XP+/6YAI9gqlVbrpJVksXoD7+MN+zmR79Z+i
         bY7a5+ximfnmQoFbS2h/rX2GkzKuX0WwiaN1kZ39OI9qK/vB8dbENBj3Vq05muNh6QQj
         JydRvF9VoUEMyRxiom12TLyWOxcS9rADEFg+VXAq1I+fxT4Cc6JrYI33z05H9YtOifed
         d8Bw==
X-Gm-Message-State: AOAM530NVeB66k5t5RTgZ/DpyCkGKV67Kn7RsO36EeFVuo5Fty6AtDMx
        dIG+0+Nge1N6vg+5wJVHhLh+ZTIjkcoP32kMYWVI77bw6a7k+9/SClmZaAU5XYuVf78kkT7bdl6
        SwXzh69XwZQcNwaTvBycH8g==
X-Received: by 2002:a9d:1444:: with SMTP id h62mr11278369oth.166.1624651144411;
        Fri, 25 Jun 2021 12:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeem8EOmmmn5y8CPZeFaRc3c9s14pMP/nstObriZEyihVaSXAzzok2ediru14hgoYsiKudHA==
X-Received: by 2002:a9d:1444:: with SMTP id h62mr11278356oth.166.1624651144276;
        Fri, 25 Jun 2021 12:59:04 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r204sm1467374oih.11.2021.06.25.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:59:03 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 2/4] fpga: add FPGA_MGR_REIMAGE flag
Date:   Fri, 25 Jun 2021 12:58:47 -0700
Message-Id: <20210625195849.837976-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195849.837976-1-trix@redhat.com>
References: <20210625195849.837976-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If this flag is set the reimage ops will be used otherwise the
reconfig ops will be used to write the image

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 53f9402d6aa17..0791e22b07f88 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_REIMAGE: Reimage the whole card, fpga bs and other device fw
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_REIMAGE                BIT(5)
 
 /**
  * struct fpga_image_info - information specific to an FPGA image
-- 
2.26.3

